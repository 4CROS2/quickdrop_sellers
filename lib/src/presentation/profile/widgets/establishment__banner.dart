import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/domain/entity/app_entity.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/image_loader.dart';

class EstablishmentBanner extends StatefulWidget {
  const EstablishmentBanner({super.key});

  @override
  State<EstablishmentBanner> createState() => _EstablishmentBannerState();
}

class _EstablishmentBannerState extends State<EstablishmentBanner> {
  late final AppEntity _app;

  @override
  void initState() {
    super.initState();
    _app = (context.read<AppCubit>().state as Authenticated).app;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        Constants.paddingValue * 2,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Constants.mainBorderRadius,
          color: Theme.of(context).canvasColor,
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(Constants.paddingValue / 2),
            child: Row(
              spacing: Constants.paddingValue,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  height: double.infinity,
                  child: ImageLoader(imageUrl: ''),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: Constants.paddingValue / 2,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          _app.establishment.companyName.capitalize(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Questrial',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        _app.accountInformation.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
