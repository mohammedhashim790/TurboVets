# TurboVets — Flutter App

Repository: https://github.com/mohammedhashim790/TurboVets

A Flutter + Angular demo: Whatsapp-style chat UI with Hive persistence and a responsive Angular dashboard.

## Features

- Whatsapp-style chat bubbles
- Dark / Light mode (system-configurable)
- Message persistence with Hive database
- Auto-reply simulation (mocked)
- Scroll-to-bottom button with unread message counter
- Supports Default Kayboard Emoji
- Mocked real-time messaging

Responsive Angular Dashboard:
- Ticket Viewer (mobile-responsive)
- Knowledgebase Editor (Markdown preview)
- Live Logs Panel (mockable test logs)
- Tailwind CSS responsive styling

## Quick Start

Prerequisites
- Flutter 3.38.3 (Dart 3.10.1)
- Node / Angular CLI for dashboard (see Angular section)
- macOS for iOS simulator builds

Repository files of interest:
- Flutter entry: [lib/main.dart](lib/main.dart)
- Chat UI: [lib/views/chat_window/chat_window.dart](lib/views/chat_window/chat_window.dart)
- Hive service: [lib/services/hive.service.dart](lib/services/hive.service.dart)
- Message model: [`MessageModel`](lib/models/message.model.dart)
- pubspec: [pubspec.yaml](pubspec.yaml)

### Flutter (app)

1. Open project
```bash 
    cd /flutter_app
```

2. Install dependencies
```bash
    flutter pub get 
```

3. Generate code (Hive adapters, etc.)
```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. Run app examples
    - List targets: flutter devices
    - Android emulator (example): flutter run -d emulator-5554
    - iOS simulator: flutter run -d ios
    - Physical device: flutter run -d <deviceId>
```bash
   flutter devices
   
   #android
   flutter run -d emulator-5554
   #ios Simulator
   flutter run -d ios
   #physical device
   flutter run -d <deviceId>
```

Notes:
- The app uses Hive. Adapters are registered in [lib/main.dart](lib/main.dart).
- All communications in this demo expect HTTP (no HTTPS) for the Angular dashboard.

### Angular (dashboard)

Requirements:
- Angular CLI 17.0.9
- Node (tested with Node 24.2.0; your environment may differ)
- npm (11.3.0)

1. Change Working directory to the Angular project folder (dashboard)
```bash
    cd /webpage 
```
2. Install packages:
```bash
    npm install 
```
3. Start dev server:
```bash
    npm start -- --host 0.0.0.0 --port 4200 
```

`--host` allows connections from devices on the same network.

Verify:
- Open http://localhost:4200 in a browser (or use your machine IP for physical devices).

### WebView URL mapping (when using dashboard inside the Flutter WebView)
- Android emulator: use `10.0.2.2:4200` (Configured by default in the application)
- iOS simulator: use `localhost:4200` (or machine private IP)
- Physical devices: use your machine's private IP and port (e.g. 192.168.x.x:4200)

Application and devices access `HTTP` communications only.

## Troubleshooting

- If messages do not appear, confirm Hive box is opened and adapters generated (see [lib/main.dart](lib/main.dart)).
- For Android emulator -> local server access, use `10.0.2.2`.
- Run the following command to update Hive Generated models
```bash 
   flutter packages pub run build_runner build --delete-conflicting-outputs
``` 

## Screenshot


# Chat Module
<img src="assets/Simulator%20Screenshot%20-%20IPhone%2014%20Pro%20Max%20-%202025-12-02%20at%2014.45.07.png" width="300"/>

# Dashboard (Ticket Viewer)
<img src="assets/Simulator%20Screenshot%20-%20IPhone%2014%20Pro%20Max%20-%202025-12-02%20at%2014.46.58.png" width="300"/>

# Dashboard (Knowledge Base Editor)
<img src="assets/Simulator%20Screenshot%20-%20IPhone%2014%20Pro%20Max%20-%202025-12-02%20at%2014.47.05.png" width="300"/>

# Dashboard (Logs)
<img src="assets/Simulator%20Screenshot%20-%20IPhone%2014%20Pro%20Max%20-%202025-12-02%20at%2014.47.12.png" width="300">






