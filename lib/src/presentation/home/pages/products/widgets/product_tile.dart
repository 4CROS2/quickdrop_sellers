import 'package:custom_dropdown_menu/custom_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/products/cubit/products_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/image_loader.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late final GlobalKey _optionsKey;
  late final ProductsCubit _productsCubit;
  @override
  void initState() {
    super.initState();
    _optionsKey = GlobalKey();
    _productsCubit = context.read<ProductsCubit>();
  }

  void _showProduct(BuildContext context, {required String productId}) {
    context.push(
      '/productdetail/$productId',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.paddingTop,
      child: Material(
        clipBehavior: Clip.hardEdge,
        type: MaterialType.card,
        borderRadius: Constants.mainBorderRadius,
        child: InkWell(
          onTapDown: (TapDownDetails details) {
            _productsCubit.hapticClickVibration();
          },
          onTapUp: (TapUpDetails details) {
            _productsCubit.hapticClickVibration();
          },
          onTap: () => _showProduct(context, productId: 'ass'),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(
                Constants.paddingValue / 2,
              ),
              child: Row(
                spacing: Constants.paddingValue / 2,
                children: <Widget>[
                  ImageLoader(imageUrl: ''),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Constants.paddingValue / 2,
                      children: <Widget>[
                        Text(
                          'Producto 1',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Questrial',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '23.000',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Constants.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    key: _optionsKey,
                    onPressed: () {
                      CustomDropdownMenu.showCustomMenu(
                        context,
                        widgetKey: _optionsKey,
                        options: <String>['editar', 'eliminar'],
                        onSelected: (String value) {},
                      );
                    },
                    icon: Icon(Icons.more_horiz_rounded),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
