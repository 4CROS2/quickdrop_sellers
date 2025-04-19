import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/toastificastion.dart';

class SubmitNewProductButton extends StatelessWidget {
  const SubmitNewProductButton({
    required GlobalKey<FormState> formKey,
    required this.cubit,
    super.key,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final NewProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: Constants.mainBorderRadius,
        clipBehavior: Clip.antiAlias,
        color: Constants.secondaryColor,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            FocusScope.of(context).unfocus();

            if (!_formKey.currentState!.validate()) {
              return;
            }
            final String? message = cubit.validateNewProduct();
            if (message != null) {
              AppToastification.showError(
                context: context,
                message: message,
              );
              return;
            }
            cubit.saveNewProduct();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.borderValue * 2,
              vertical: Constants.paddingValue,
            ),
            child: Text(
              'registrar producto'.capitalize(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Questrial',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
