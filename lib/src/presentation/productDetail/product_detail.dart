import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({required String productId, super.key})
      : _productId = productId;
  final String _productId;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget._productId,
        ),
      ),
    );
  }
}
