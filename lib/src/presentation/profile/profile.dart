import 'package:extensions/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/profile/widgets/establishment__banner.dart';
import 'package:quickdrop_sellers/src/presentation/profile/widgets/information_tile.dart';
import 'package:quickdrop_sellers/src/presentation/profile/widgets/profile_header.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final TapGestureRecognizer _recognizer;
  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        _test(context);
      };
  }

  void _test(BuildContext context) {
    HapticFeedback.selectionClick();
    context.push('/deleteaccount');
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (BuildContext context, AppState state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: ProfileHeader(),
            body: Padding(
              padding: Constants.mainPaddingWithOutBottom,
              child: Column(
                spacing: Constants.paddingValue,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: EstablishmentBanner(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: Constants.mainPhysics,
                      child: Column(
                        spacing: Constants.paddingValue,
                        children: <Widget>[
                          InformationTile(
                            onTap: () {},
                            icon: Icons.business_rounded,
                            label: 'Datos de la empresa',
                            description: 'informacion del establecimiento',
                          ),
                          InformationTile(
                            onTap: () {},
                            alert: !state.app.accountInformation.isVerify,
                            icon: Icons.email_rounded,
                            label: 'cuenta',
                            description: 'verificacion de la cuenta',
                          ),
                          InformationTile(
                            onTap: () {},
                            icon: Icons.person_outline_rounded,
                            label: 'Datos de vendedor',
                          ),
                          InformationTile(
                            onTap: () => context.push('/schedule'),
                            icon: Icons.schedule_rounded,
                            label: 'Horario de operaciones',
                            description: 'establecer horario',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: Constants.authInputContent,
                    child: Text.rich(
                      TextSpan(
                        text: 'puedes '.capitalize(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Questrial'),
                        children: <InlineSpan>[
                          TextSpan(
                              text: 'cerrar tu cuenta ',
                              style: TextStyle(color: Constants.secondaryColor),
                              recognizer: _recognizer),
                          TextSpan(text: 'cuando desees.')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
