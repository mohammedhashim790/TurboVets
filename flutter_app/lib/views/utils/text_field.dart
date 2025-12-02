import 'package:flutter/material.dart';

typedef TextInputFieldOnMessage = Function(String text);

class TextInputField extends StatefulWidget {
  final TextInputFieldOnMessage onMessage;

  const TextInputField({super.key, required this.onMessage});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final TextEditingController _controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F20),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      constraints: BoxConstraints(
        // 40% of  will be the maximum
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
            maxLines: 10,
            scrollController: _scrollController,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "Write a message....",
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Flutter String support emoji's by default.
              // IconButton(
              //   icon: Icon(Icons.emoji_emotions_outlined),
              //   color: Colors.grey[400],
              //   hoverColor: Colors.white.withOpacity(0.1),
              //   highlightColor: Colors.white.withOpacity(0.1),
              //   onPressed: () {},
              //   visualDensity: VisualDensity.compact,
              //   constraints: const BoxConstraints(),
              //   padding: const EdgeInsets.all(8),
              // ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_upward_rounded),
                  color: Colors.black,
                  iconSize: 20,
                  tooltip: 'Send',
                  onPressed: () {
                    widget.onMessage.call(_controller.text);
                    _controller.clear();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
