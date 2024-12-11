import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/authentication_data_page.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/establishment_information.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/seller_data_page.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_back_button.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_navigation_page_buttons.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/toastificastion.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late final PageController _pageController;

  late final GlobalKey<FormState> _credentialForm;
  late final GlobalKey<FormState> _sellerDataForm;
  late final GlobalKey<FormState> _estableshmentForm;

  @override
  void initState() {
    super.initState();
    _credentialForm = GlobalKey<FormState>();
    _sellerDataForm = GlobalKey<FormState>();
    _estableshmentForm = GlobalKey<FormState>();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      EstablishmentInformation(
        index: 0,
        globalkey: _estableshmentForm,
      ),
      SellerDataPage(
        index: 1,
        globalKey: _sellerDataForm,
      ),
      AuthenticationDataPage(
        index: 2,
        globalKey: _credentialForm,
      ),
    ];
    return BlocProvider<SignupCubit>(
      create: (BuildContext context) => sl<SignupCubit>(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (BuildContext context, SignupState state) {
          if (state.signinState == SigninState.loading) {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return LoadingPopUp();
              },
            );
          }
          if (state.signinState == SigninState.error) {
            if (Navigator.canPop(context)) {
              context.pop();
            }
            AppToastification.showError(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        builder: (BuildContext context, SignupState state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  AuthBackButton(),
                  Flexible(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: context.read<SignupCubit>().setPage,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ...List<Widget>.generate(
                          pages.length,
                          (int index) => pages[index],
                        ),
                      ],
                    ),
                  ),
                  AuthNavigationPageButtons(
                    formsGlobalskeys: <GlobalKey<FormState>>[
                      _estableshmentForm,
                      _sellerDataForm,
                      _credentialForm,
                    ],
                    pageController: _pageController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingPopUp extends StatelessWidget {
  const LoadingPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: Constants.mainBorderRadius,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 60,
            maxHeight: 60,
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Constants.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
