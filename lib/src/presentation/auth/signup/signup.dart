import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/authentication_data_page.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/establishment_information.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/pages/seller_data_page.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_back_button.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_navigation_page_buttons.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
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
      AuthenticationDataPage(
        index: 0,
        globalKey: _credentialForm,
      ),
      SellerDataPage(
        index: 1,
        globalKey: _sellerDataForm,
      ),
      EstablishmentInformation(
        index: 2,
        globalkey: _estableshmentForm,
      )
    ];
    return BlocProvider<SignupCubit>(
      create: (BuildContext context) => sl<SignupCubit>(),
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (BuildContext context, SignupState state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
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
                      _credentialForm,
                      _sellerDataForm,
                      _credentialForm
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
