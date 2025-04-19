import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: Constants.paddingValue,
        ).copyWith(
          left: Constants.borderValue,
        ),
        child: Material(
          type: MaterialType.card,
          borderRadius: Constants.mainBorderRadius * 2,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => context.pop(),
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
