import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension AppDialog on BuildContext {
  ///
  ///
  /// Native App Dialogs for different Platforms
  ///
  /// Example :
  ///   `
  ///   context.showAppDialog(
  ///     title: Text("Title"),
  ///     content: Text("Content"),
  ///       actions: [
  ///        AppDialogActions(onPressed: (){
  ///          Navigator.of(context).push(MaterialPageRoute(
  ///              builder: (context) => const ThisScreen()));
  ///        }, child: Text("Action1")),
  ///        AppDialogActions(onPressed: (){
  ///          Navigator.of(context).pop();
  ///        }, child: Text("Action2")),
  ///      ]);`
  ///
  ///
  ///
  ///
  void showAppDialog({
    required Widget title,
    required Widget content,
    List<Widget>? actions,
    bool? barrierDismissible,
  }) {
    var dialog = // (Platform.isIOS)
        //     ?
        CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions ?? [],
        );
    // : AlertDialog(
    //     title: title,
    //     content: Material(child: content),
    //     actions: actions ?? [],
    //   );

    if (mounted) {
      showDialog(
        context: this,
        builder: (_) => dialog,
        barrierDismissible: barrierDismissible ?? false,
      );
    }
  }

  void showLoader({String? titleText, bool barrierDismissible = false}) {
    Widget loader = const Padding(
      padding: EdgeInsets.all(8.0),
      child: CupertinoActivityIndicator(),
    );

    Widget title = const SizedBox();
    if (titleText != null) {
      title = Text(titleText, style: TextStyle(fontSize: 12));
    }

    var dialog = CupertinoAlertDialog(title: title, content: loader);

    if (mounted) {
      showDialog(
        context: this,
        barrierDismissible: barrierDismissible,
        builder: (context) => dialog,
      );
    }
  }

  void showSnackBar({required String title}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(title, textAlign: TextAlign.center),
      ),
    );
  }

  void pop() {
    return Navigator.of(this).pop();
  }
}
