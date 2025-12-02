# TurboVets — Flutter App

Repository: https://github.com/mohammedhashim790/TurboVets

Lightweight Flutter chat demo with Hive persistence and a mocked real-time dashboard backend.

Version
- Flutter: 3.38.3
- Dart: 3.10.1

Overview
- Whatsapp-style chat UI with message persistence (Hive).
- Mocked auto-reply / real-time simulation for demo purposes.
- Dark / Light theme support (system configurable).
- Emoji picker, quick reactions, unread counter + scroll-to-bottom control.

Quick Links
- Flutter entry: lib/main.dart
- Chat UI: lib/views/chat_window/chat_window.dart
- Hive service: lib/services/hive.service.dart
- Message model: lib/models/message.model.dart

Prerequisites
- Flutter 3.38.3 (Dart 3.10.1)
- Android SDK / Xcode for device builds (macOS for iOS)
- Optional: Chrome for web target

Installation (Flutter)
1. Clone repository
   git clone https://github.com/mohammedhashim790/TurboVets
   cd TurboVets/flutter_app

2. Get packages
   flutter pub get

3. Generate code (Hive adapters / generated files)
   flutter packages pub run build_runner build --delete-conflicting-outputs

4. Run the app
   - List devices: flutter devices
   - Run on default device: flutter run
   - Run on specific device: flutter run -d <deviceId>
   - Web: flutter run -d chrome

Notes for local WebView / Dashboard integration
- If embedding the Angular dashboard in a WebView:
  - Android emulator uses 10.0.2.2 for host machine
  - iOS simulator can use localhost or host private IP
  - Use machine private IP for physical devices
- Demo uses HTTP (no HTTPS by default); configure network permissions if required.

Model structure and purpose

MessageModel (lib/models/message.model.dart)
- Purpose: primary persistence model for chat messages in Hive.
- Typical fields:
  - String messageId — unique id for the message (UUID)
  - String text — message body
  - DateTime createdAt — timestamp for ordering/display
  - bool isSender — true if sent by the local user
- Adapter: MessageModelAdapter (generated via build_runner)
- Stored in a Hive Box (e.g. 'messages') and listened to via a ValueListenableBuilder for UI updates.

Chat (optional / project-specific)
- The project currently persists individual messages; if you add ChatModel:
  - ChatModel contains chatId, chatName, createdAt and a list of MessageModel or message references.
  - Use separate Hive boxes for chats and messages or nest message lists inside a ChatModel (requires adapter generation).

Services

MessageService / HiveService (lib/services/hive.service.dart)
- Responsibilities:
  - Open Hive boxes and register adapters at app startup (main.dart).
  - CRUD operations for messages (addMessage, getAll, watch events).
  - Provide a listenable Box for UI builders (ValueListenableBuilder).
  - Simulate auto-reply or mocked remote responses when adding messages (implementation detail).

Development tips
- After model changes, re-run build_runner to regenerate adapters:
  flutter packages pub run build_runner build --delete-conflicting-outputs
- Ensure Hive.initFlutter() and adapter registrations run before opening boxes (check lib/main.dart).
- Use MessageService.messages.watch() to respond to new messages and trigger UI updates/auto-replies.

Contributing
- Open issues and PRs at the repository above. Keep changes small and include build_runner adapter updates for model changes.

License
- Refer to repository for license details.

