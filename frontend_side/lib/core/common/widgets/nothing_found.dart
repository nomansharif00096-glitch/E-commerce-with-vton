import 'package:flutter/material.dart';

class NothingFound extends StatelessWidget {
  final String title;
  const NothingFound({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/nothing_found.jpg')),
        Positioned(
            right: 29,
            bottom: 1,
            child: (Text(
              title,
              style: TextStyle(color: Colors.black54, fontSize: 17),
            )))
      ]),
    );
  }
}
