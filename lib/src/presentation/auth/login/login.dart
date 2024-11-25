import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/cubit/login_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/widgets/auth_button.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/widgets/forgot_password.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_input.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_title.dart';

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
          listener: (BuildContext context, LoginState state) {
            if (state is Error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
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
                      ),
                    ),
                    Padding(
                      padding: Constants.authInputPadding,
                      child: AuthInput(
                        controller: _password,
                        hintText: 'contraseña',
                        isPassword: true,
                      ),
                    ),
                    ForgotPassword(),
                    AuthButton(
                      onTap: () {
                        context.read<LoginCubit>().login(
                              email: _email.text,
                              password: _password.text,
                            );
                      },
                    )
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
