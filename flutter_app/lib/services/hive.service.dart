import 'package:flutter_app/models/chat.model.dart';
import 'package:flutter_app/models/message.model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _chatsBox = 'chats';
  static const String _messagesBox = 'messages';

  static final HiveService _instance = HiveService._();

  factory HiveService() => _instance;

  HiveService._();

  Future<void> addChat(ChatModel chat) async {
    final box = Hive.box<ChatModel>(_chatsBox);
    await box.put(chat.chatId, chat);
  }

  Future<void> addMessage(String chatId, MessageModel message) async {
    final box = Hive.box<ChatModel>(_chatsBox);
    final chat = box.get(chatId);
    if (chat != null) {
      chat.messages.add(message);
      await chat.save();
    }
  }

  List<ChatModel> getAllChats() {
    final box = Hive.box<ChatModel>(_chatsBox);
    return box.values.toList();
  }

  ChatModel? getChatById(String chatId) {
    final box = Hive.box<ChatModel>(_chatsBox);
    return box.get(chatId);
  }

  Future<void> deleteChat(String chatId) async {
    final box = Hive.box<ChatModel>(_chatsBox);
    await box.delete(chatId);
  }

  Future<void> clearAllData() async {
    final chatsBox = Hive.box<ChatModel>(_chatsBox);
    final messagesBox = Hive.box<MessageModel>(_messagesBox);
    await chatsBox.clear();
    await messagesBox.clear();
  }
}
