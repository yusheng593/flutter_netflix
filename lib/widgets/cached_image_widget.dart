import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_netflix/common/utils.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({super.key, required this.imgUrl, this.boxFit});

  final String? imgUrl;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl ?? movieImage,
      fit: boxFit ?? BoxFit.cover,
      errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: kRedColor, width: 3),
          ),
          child: Image.asset('assets/netflix.png')),
    );
  }
}
