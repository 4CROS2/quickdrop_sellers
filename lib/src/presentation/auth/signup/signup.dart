import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/authentication_data_page.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_navigation_page_buttons.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  late final PageController _pageController;

  late final GlobalKey<FormState> _credentialForm;

  @override
  void initState() {
    super.initState();
    _credentialForm = GlobalKey<FormState>();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (BuildContext context) => sl<SignupCubit>(),
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (BuildContext context, SignupState state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: Constants.paddingValue,
                      ).copyWith(
                        left: Constants.borderValue,
                      ),
                      child: Material(
                        color: Constants.mainColor,
                        borderRadius: Constants.mainBorderRadius * 2,
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () => context.pop(),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.arrow_back_ios_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: context.read<SignupCubit>().setPage,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        AuthenticationDataPage(
                          globalKey: _credentialForm,
                        ),
                        Center(
                          child: LottieBuilder.asset(
                            'assets/lotties/wellcome/delivery.json',
                          ),
                        ),
                        Center(
                          child: Text('two'),
                        )
                      ],
                    ),
                  ),
                  AuthNavigationPageButtons(
                    formsGlobalskeys: <GlobalKey<FormState>>[
                      _credentialForm,
                    ],
                    pageController: _pageController,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
