import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({
    required String imageUrl,
    BoxFit fit = BoxFit.cover,
    super.key,
  })  : _url = imageUrl,
        _boxFit = fit;
  final String _url;
  final BoxFit _boxFit;

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: widget._boxFit,
      imageUrl: widget._url,
      errorWidget: (
        BuildContext context,
        String url,
        Object error,
      ) {
        return Material(
          borderRadius: Constants.mainBorderRadius / 2,
          surfaceTintColor: Constants.secondaryColor,
          clipBehavior: Clip.hardEdge,
          color: Constants.secondaryColor.withValues(
            alpha: .2,
          ),
          child: Padding(
            padding: EdgeInsets.all(
              Constants.paddingValue,
            ),
            child: Center(
              child: Icon(
                Icons.store_rounded,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
