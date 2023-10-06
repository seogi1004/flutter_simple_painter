import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final int page;

  const PageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    String content = page == 0
        ? 'Menu 1'
        : page == 1
            ? 'Home'
            : 'Menu 2';
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(content,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
