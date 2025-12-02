import 'package:flutter/material.dart';
import 'package:flutter_app/views/utils/view_config.dart';

class DrawerTitle extends StatelessWidget {
  final String title;
  DrawerTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kTextStyle(context)),
          Divider(height: 1, thickness: 1.0),
        ],
      ),
    );
  }
}
