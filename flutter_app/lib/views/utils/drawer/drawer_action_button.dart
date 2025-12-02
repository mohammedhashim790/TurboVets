import 'package:flutter/material.dart';
import 'package:flutter_app/views/utils/view_config.dart';

typedef DrawerButtonCallback = VoidCallback;

class DrawerActionButton extends StatelessWidget {
  final Icon icon;

  final String text;

  final DrawerButtonCallback onTap;

  const DrawerActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded( child: icon),
            Expanded(
              flex:5,
              child: Text(text, style: kTextStyle(context)),
            ),
          ],
        ),
      ),
    );
  }
}
