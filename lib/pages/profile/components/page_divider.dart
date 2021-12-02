import 'package:flutter/material.dart';

class PageDivider extends StatelessWidget {
  const PageDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Flex(
        direction: Axis.horizontal,
        children: const [
          Expanded(
            child: Divider(
              color: Color(0xFF000000),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
