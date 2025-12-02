import 'dart:async';
import 'dart:math';

import 'package:flutter_app/models/message.model.dart';
import 'package:hive_flutter/hive_flutter.dart';




class MessageService {
  static const String _chatsBox = 'chats';
  static const String _messagesBox = 'messages';

  static final MessageService _instance = MessageService._();

  factory MessageService() => _instance;

  final Random random = Random();

  Box<MessageModel> get messages {
    return Hive.box<MessageModel>(_messagesBox);
  }

  static final List<String> _sampleMessages = [
    "Background apps, location services, notifications, weak signal, or an aging battery often cause unexpected phone battery drain.",
    "Here are some coffee shop name ideas: Brew & Bloom, Roast Haven, Morning Muse Café, Bean Voyage, The Steamy Spoon.",
    "Machine learning is a broad field of algorithms that learn from data, while deep learning is a subset using multi-layer neural networks for more complex patterns.",
    "Happy Birthday! May your year be full of bright stars, cosmic adventures, and discoveries as amazing as the night sky!",
    "Politely decline by thanking the person, giving a brief reason, and keeping it friendly: 'Thanks so much! I can't make it, but please keep me in mind next time.'",
    "A researcher detects a mysterious deep-space signal that triggers contact with an advanced civilization, forcing them to choose between protecting humanity or revealing a truth that could change society.",
    "Quick vegetarian pantry recipe: Chickpea Tomato Stew—sauté garlic, add canned tomatoes, chickpeas, broth, and spices; simmer 10 minutes and serve over rice or pasta.",
    "Wi-Fi uses invisible waves that carry messages through the air; your router sends them and your device catches them so it can talk to the internet.",
    "Productivity ideas: Use Pomodoro, set up a dedicated workspace, make a 3-item priority list, disable non-essential notifications, and use time blocking.",
    "Writing prompt: You find a diary that lets you talk to versions of yourself from different times—one of them needs help to prevent a mistake that could erase your future.",
  ];

  MessageService._();

  Future<void> addMessage(MessageModel message) async {
    messages.add(message);
    return Future.delayed(Duration(seconds: 1), () {
      messages.add(
        MessageModel(
          text: _sampleMessages[random.nextInt(_sampleMessages.length)],
          isSender: false,
        ),
      );
      return;
    });
  }

  Future<void> addReply( MessageModel message) async {
    messages.add(message);
  }

  List<MessageModel> getAllChats() {
    return messages.values.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<void> clearAllData() async {
    await messages.clear();
  }
}
