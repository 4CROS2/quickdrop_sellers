import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/theme_extensions.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';

class TagsInputs extends StatefulWidget {
  const TagsInputs({super.key});

  @override
  State<TagsInputs> createState() => _TagsInputsState();
}

class _TagsInputsState extends State<TagsInputs> {
  late final TextEditingController _controller;
  late final NewProductCubit _cubit;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _cubit = context.read<NewProductCubit>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setTag() {
    if (_controller.text.isNotEmpty) {
      _cubit.addTag(
        _controller.text,
      );
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewProductCubit, NewProductState, List<String>>(
      selector: (NewProductState state) {
        return state.newProduct.tags;
      },
      builder: (BuildContext context, List<String> state) {
        final TextStyle style = TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'Questrial',
          color: context.textTheme.titleLarge!.color,
        );
        return Column(
          spacing: Constants.paddingValue,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              cursorOpacityAnimates: true,
              cursorRadius: Radius.circular(Constants.borderValue),
              enableSuggestions: true,
              onSubmitted: (String value) {
                _setTag();
              },
              decoration: InputDecoration(
                label: Text(
                  'agregar etiqueta'.capitalize(),
                ),
                labelStyle: style,
                helperText: 'agregue 3 tags como minimo*'.capitalize(),
                suffixIcon: IconButton(
                  onPressed: _setTag,
                  icon: Icon(Icons.check),
                ),
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              runSpacing: Constants.paddingValue,
              spacing: Constants.paddingValue,
              alignment: WrapAlignment.start,
              children: <Widget>[
                ...state.asMap().entries.map(
                  (MapEntry<int, String> tags) {
                    final int index = tags.key;
                    final String tag = tags.value;
                    return Material(
                      type: MaterialType.card,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: Constants.mainBorderRadius,
                      child: InkWell(
                        onTap: () => _cubit.removeTag(index: index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Constants.paddingValue * 2,
                            vertical: Constants.paddingValue,
                          ),
                          child: Text(
                            tag.capitalize(),
                            style: style,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }
}
