import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/utils/extensions.dart';
import 'package:flutter_app/views/utils/view_config.dart';

class SenderBubble extends StatelessWidget {
  final String message;
  final DateTime time;

  const SenderBubble({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return _Bubble(
      message: message,
      time: time,
      color: const Color(0xFF005C4B),

      alignment: Alignment.centerRight,

      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      icon: const Icon(Icons.done_all, size: 14, color: Color(0xFF53BDEB)),
    );
  }
}

class ReceiverBubble extends StatelessWidget {
  final String message;
  final DateTime time;

  const ReceiverBubble({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return _Bubble(
      message: message,
      time: time,
      color: const Color(0xFF1F2C34),

      alignment: Alignment.centerLeft,

      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
    );
  }
}

class _Bubble extends StatefulWidget {
  final String message;
  final DateTime time;
  final Color color;
  final Alignment alignment;
  final BorderRadiusGeometry borderRadius;
  final Widget? icon;

  const _Bubble({
    required this.message,
    required this.time,
    required this.color,
    required this.alignment,
    required this.borderRadius,
    this.icon,
  });

  @override
  State<_Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<_Bubble> {
  bool _isExpanded = false;
  static const int _textLengthThreshold = 200;

  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.message.length > _textLengthThreshold;
    return Align(
      alignment: widget.alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: EdgeInsets.all(8.0),
        constraints: BoxConstraints(
          // Maximum width the bubble can hanlder
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message,
              maxLines: (_isExpanded || !isLongText) ? null : 5,
              overflow: (_isExpanded || !isLongText)
                  ? null
                  : TextOverflow.ellipsis,
              style: kTextStyle(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: isLongText,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? "Show less" : "Read more",
                      style: kTextStyle(context).copyWith(
                        color: const Color(0xFF53BDEB),
                        fontSize: kTextSmall(context),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.time.toHoursMinutes(),
                  style: kTextStyle(
                    context,
                  ).copyWith(fontSize: kTextSmall(context)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
