import 'package:flutter/material.dart';
import 'package:flutter_app/services/hive.service.dart';
import 'package:flutter_app/views/utils/text_field.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/message.model.dart';
import '../utils/bubble/bubble.dart';
import '../utils/view_config.dart';

class ChatWindow extends StatefulWidget {
  ChatWindow({super.key});

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  TextEditingController textEditingController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final MessageService _messageService = MessageService();

  List<Widget> _messages = [];

  bool _activeScrollList = false;

  String chatId = "";

  int newMessageCount = 0;

  void _checkBounds() {
    if (!_scrollController.hasClients) return;
    final double max = _scrollController.position.maxScrollExtent;
    final double curr = _scrollController.position.pixels;
    // 50 as a factor after multiple testing with respect to layout orientation
    final bool shouldBottom = (max - curr) > 50;
    setState(() {
      _activeScrollList = max > 0 && shouldBottom;
      if (!_activeScrollList) newMessageCount = 0;
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      // Tiny factor to avoid overflow
      _scrollController.position.maxScrollExtent + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setState(() {
      newMessageCount = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkBounds);

    _readChat();
    _openSocket();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _openSocket() {
    /// Listens to events in Messages
    _messageService.messages.watch().listen((message) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_activeScrollList) _scrollToBottom();
        if (!(message.value as MessageModel).isSender) {
          setState(() {
            newMessageCount++;
          });
        }
      });
    });
  }

  void _readChat() {
    _messages = _messageService
        .getAllChats()
        .map((message) => _newMessage(message))
        .toList();
  }

  Widget _newMessage(MessageModel message) {
    if (message.isSender) {
      return SenderBubble(message: message.text, time: message.createdAt);
    }
    return ReceiverBubble(message: message.text, time: message.createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: ValueListenableBuilder<Box<MessageModel>>(
                valueListenable: _messageService.messages.listenable(),
                builder: (context, value, _) {
                  if (value.values.toList().isEmpty) return _emptyChat();

                  final messages = value.values.toList()
                    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: messages.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) =>
                        _newMessage(messages[index]),
                  );
                },
              ),
            ),
            TextInputField(onMessage: (text) => handleSend(text, true)),
          ],
        ),
        Visibility(
          visible: _activeScrollList,
          child: Positioned(
            bottom: 120,
            right: 0,
            child: _scrollBottomButton(),
          ),
        ),
      ],
    );
  }

  Widget _emptyChat() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Hello!, Start a new conversation!",
          style: kTextStyle(context).copyWith(fontSize: kTextLarge(context)),
        ),
      ),
    );
  }

  Widget _scrollBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () {
              _scrollToBottom();
            },
            child: Icon(Icons.keyboard_arrow_down_rounded),
          ),
          Positioned(
            right: 0,
            top: -10,
            child: Visibility(
              visible: newMessageCount > 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "$newMessageCount",
                    style: kTextStyle(context).copyWith(
                      fontSize: kTextSmall(context),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleSend(String text, bool isSender) {
    if (isSender) {
      setState(() {
        _messages.add(SenderBubble(message: text, time: DateTime.now()));
      });
      _messageService.addMessage(MessageModel(text: text, isSender: isSender));
    }
  }
}
