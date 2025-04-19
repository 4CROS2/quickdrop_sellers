import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/theme_extensions.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/widgets/image_selected.dart';

class ImagesPicker extends StatefulWidget {
  const ImagesPicker({super.key});

  @override
  State<ImagesPicker> createState() => _ImagesPickerState();
}

class _ImagesPickerState extends State<ImagesPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewProductCubit, NewProductState, List<XFile>>(
      selector: (NewProductState state) {
        return state.newProduct.images;
      },
      builder: (BuildContext context, List<XFile> state) {
        return Material(
          borderRadius: Constants.mainBorderRadius,
          type: MaterialType.card,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(Constants.paddingValue),
              child: Column(
                spacing: Constants.paddingValue,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'imagenes del producto'.capitalize(),
                    style: TextStyle(
                      color: context.textTheme.titleLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Questrial',
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: Constants.paddingValue,
                    runSpacing: Constants.paddingValue,
                    children: <Widget>[
                      ...state.asMap().entries.map(
                        (MapEntry<int, XFile> imageEntry) {
                          final int index = imageEntry.key;
                          final XFile value = imageEntry.value;
                          return ImageSelected(
                            image: value.path,
                            index: index,
                          );
                        },
                      ),
                      Material(
                        clipBehavior: Clip.hardEdge,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: Constants.mainBorderRadius / 2,
                        child: InkWell(
                          onTap: () {
                            context.read<NewProductCubit>().selectImages();
                          },
                          child: const SizedBox(
                            width: 60,
                            height: 60,
                            child: Icon(Icons.add),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
