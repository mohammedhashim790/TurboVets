import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/views/utils/view_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final WebViewController controller;

  String url = "http://localhost:4200";

  int progress = 0;

  bool pageFailed = false;
  String? errorDescriptor = "";

  @override
  void initState() {
    super.initState();
    setController();
  }

  void setController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                this.progress = progress;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {});
          },
          onPageFinished: (String url) {
            setState(() {});
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              pageFailed = true;
              errorDescriptor =
                  'Failed to load dashboard: ${error.description}';
            });
          },
          onSslAuthError: (_) {
            setState(() {
              pageFailed = true;
            });
          },
          onNavigationRequest: (_) {
            return NavigationDecision.navigate;
          },
        ),
      );
    _loadURl();
  }

  void _loadURl() {
    String dashboardUrl = (Platform.isAndroid)
        ? "http://10.0.2.2:4200"
        : "http://localhost:4200";

    controller.loadRequest(Uri.parse(dashboardUrl));
  }

  void _reload() {
    setState(() {
      pageFailed = false;
      errorDescriptor = null;
      progress = 0;
    });
    controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Visibility(
            visible: progress < 100.0,
            child: LinearProgressIndicator(),
          ),
          Builder(
            builder: (context) {
              if (pageFailed && errorDescriptor != null) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel, color: Colors.red),
                        Text(
                          errorDescriptor!,
                          style: kTextStyle(
                            context,
                          ).copyWith(fontSize: kTextLarge(context)),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(onPressed: _reload, child: Text("Retry")),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(child: WebViewWidget(controller: controller!));
            },
          ),
        ],
      ),
    );
  }
}
