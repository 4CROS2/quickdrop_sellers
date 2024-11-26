import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/cubit/login_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/widgets/auth_button.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/widgets/forgot_password.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/widgets/no_account_button.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_input.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_title.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/toastificastion.dart';
import 'package:toastification/toastification.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (LoginState previous, LoginState current) {
            if (previous is Loading) {
              Future<void>.delayed(
                Duration(milliseconds: 300),
                () {
                  if (mounted) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.pop();
                    });
                  }
                },
              );
            }
            return true;
          },
          listener: (BuildContext context, LoginState state) {
            if (state is Error) {
              toastification.dismissAll();
              AppToastification.showError(
                context: context,
                message: state.message,
              );
            }
            if (state is Loading) {
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => LoadingPopUp(),
              );
            }
          },
          builder: (BuildContext context, LoginState state) {
            return SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: Constants.mainPadding,
                  children: <Widget>[
                    AuthTitle(),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: Constants.authInputPadding,
                      child: AuthInput(
                        controller: _email,
                        hintText: 'correo',
                        validator: emailvalidator,
                      ),
                    ),
                    Padding(
                      padding: Constants.authInputPadding,
                      child: AuthInput(
                        controller: _password,
                        hintText: 'contraseña',
                        isPassword: true,
                        validator: passwordValidator,
                      ),
                    ),
                    ForgotPassword(),
                    AuthButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                                email: _email.text,
                                password: _password.text,
                              );
                        }
                      },
                    ),
                    NoAccountButton(),
                  ],
                ),
              ),
            );
          },
        ),
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
        child: Padding(
          padding: EdgeInsets.all(
            Constants.paddingValue * 2,
          ),
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
