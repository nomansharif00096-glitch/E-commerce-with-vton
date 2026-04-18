import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWrapper extends StatelessWidget {
  final String image;

  const ImageWrapper({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Image.asset(
        'assets/vectors/loading.gif',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      fit: BoxFit.cover,
      width: double.infinity,
      imageUrl: image,
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/noImage.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
