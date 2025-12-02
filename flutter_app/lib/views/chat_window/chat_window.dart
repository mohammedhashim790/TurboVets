import 'package:flutter/material.dart';
import 'package:flutter_app/models/chat.model.dart';
import 'package:flutter_app/models/message.model.dart';
import 'package:flutter_app/services/hive.service.dart';
import 'package:flutter_app/views/utils/text_field.dart';
import 'package:uuid/uuid.dart';

import '../utils/bubble/bubble.dart' show SenderBubble, ReceiverBubble;

class ChatWindow extends StatefulWidget {
  String? id;
  ChatWindow({super.key, this.id});

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  TextEditingController textEditingController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final HiveService _hiveService = HiveService();

  final List<Widget> _messages = [];

  bool _activeScrollList = false;

  void _chatScrollListener() {
    final double max = _scrollController.position.maxScrollExtent;
    final double curr = _scrollController.position.pixels;
    // 50 as a factor after multiple testing with respect to layout orientation
    final bool shouldBottom = (max - curr) > 50;
    setState(() {
      _activeScrollList = max > 0 && shouldBottom;
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_chatScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: _messages.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) => _messages[index],
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
      ),
    );
  }

  Widget _scrollBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () {
          _scrollToBottom();
        },
        child: Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }

  void handleSend(String text, bool isSender) {
    setState(() {
      if (widget.id == null) {
        widget.id = Uuid().v4();
        _hiveService.addChat(
          ChatModel(chatId: widget.id!, chatName: "New Chat", messages: []),
        );
      }
      _hiveService.addMessage(
        widget.id!,
        MessageModel(text: text, isSender: isSender),
      );
      if (isSender) {
        _messages.add(SenderBubble(message: text, time: DateTime.now()));
      } else {
        _messages.add(ReceiverBubble(message: text, time: DateTime.now()));
      }
      if (_messages.length > 18) {
        _scrollToBottom();
      }
    });
  }
}
