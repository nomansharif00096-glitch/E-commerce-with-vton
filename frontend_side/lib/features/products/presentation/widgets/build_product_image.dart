import 'package:flutter/material.dart';

Widget buildProductImage(String? url) {
  if (url == null || url.isEmpty) {
    return Image.asset(
      'assets/images/noImage.jpg',
      height: 100,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  return FadeInImage.assetNetwork(
    placeholder: 'assets/vectors/loading2.gif',
    image: url,
    fit: BoxFit.cover,
    height: 100,
    width: double.infinity,
    imageErrorBuilder: (context, error, stackTrace) {
      return Image.asset(
        'assets/images/noImage.jpg',
        height: 100,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    },
  );
}
