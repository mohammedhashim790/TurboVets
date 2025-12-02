import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'message.model.g.dart';

@HiveType(typeId: 0)
class MessageModel extends HiveObject {
  @HiveField(0)
  final String messageId;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final bool isSender;

  MessageModel({required this.text, required this.isSender})
    : messageId = Uuid().v4(),
      createdAt = DateTime.now();
}
