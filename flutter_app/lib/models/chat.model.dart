import 'package:hive/hive.dart';

import 'message.model.dart';

part 'chat.model.g.dart';

@HiveType(typeId: 1)
class ChatModel extends HiveObject {
  @HiveField(0)
  final String chatId;

  @HiveField(1)
  final String chatName;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final List<MessageModel> messages;

  ChatModel({
    required this.chatId,
    required this.chatName,
    required this.messages,
  }) : createdAt = DateTime.now();
}
