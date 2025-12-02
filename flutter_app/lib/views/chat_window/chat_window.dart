import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/hive.service.dart';
import 'package:flutter_app/views/utils/text_field.dart';

import '../../models/chat.model.dart';
import '../../models/message.model.dart';
import '../utils/bubble/bubble.dart';

class ChatWindow extends StatefulWidget {
  ChatWindow({super.key});

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  TextEditingController textEditingController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final HiveService _hiveService = HiveService();

  List<Widget> _messages = [];

  bool _activeScrollList = false;

  String chatId = "";

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

    _readChat();
  }

  void _readChat() {
    chatId = _hiveService.getChatId();
    _messages = _hiveService.getChat()!.messages.map((message) {
      if (message.isSender) {
        return SenderBubble(message: message.text, time: message.timestamp);
      }
      return ReceiverBubble(message: message.text, time: message.timestamp);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(), // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     List<ChatModel> cha = _hiveService.getAllChats();
      //     print("object");
      //   },
      // ),
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
    _hiveService.addChat(
      ChatModel(chatId: chatId, chatName: "New Chat", messages: []),
    );

    if (isSender) {
      setState(() {
        _messages.add(SenderBubble(message: text, time: DateTime.now()));
      });

      _hiveService
          .addMessage(chatId, MessageModel(text: text, isSender: isSender))
          .then((response) {
            // a delay of 2 seconds to read
            Timer(Duration(seconds: 2), () {
              _hiveService.addReply(
                chatId,
                MessageModel(text: response, isSender: false),
              );
              setState(() {
                _messages.add(
                  ReceiverBubble(message: response, time: DateTime.now()),
                );
                if (_messages.length > 18) {
                  _scrollToBottom();
                }
              });
              _scrollToBottom();
            });
          });
    }
  }
}
