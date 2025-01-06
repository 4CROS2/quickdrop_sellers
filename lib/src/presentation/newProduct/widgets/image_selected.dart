import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';

class ImageSelected extends StatelessWidget {
  const ImageSelected({
    required String image,
    required int index,
    super.key,
  })  : _image = image,
        _index = index;
  final String _image;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Constants.mainBorderRadius / 2,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.file(
                File(_image),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: () =>
                    context.read<NewProductCubit>().deleteImage(index: _index),
                child: Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
