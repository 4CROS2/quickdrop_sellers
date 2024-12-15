import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_input.dart';

class AuthenticationDataPage extends StatefulWidget {
  const AuthenticationDataPage({
    required int index,
    GlobalKey<FormState>? globalKey,
    super.key,
  })  : _globalKey = globalKey,
        _index = index;

  final int _index;
  final GlobalKey<FormState>? _globalKey;

  @override
  State<AuthenticationDataPage> createState() => _AuthenticationDataPageState();
}

class _AuthenticationDataPageState extends State<AuthenticationDataPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _verifyPasswordController;
  late final SignupCubit _signupCubit;
  bool _dataUpdated = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _verifyPasswordController = TextEditingController();
    _signupCubit = context.read<SignupCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (BuildContext context, SignupState state) {
        if (state.currentPage > widget._index &&
            state.currentPage <= widget._index + 1 &&
            !_dataUpdated) {
          _dataUpdated = true;
          _signupCubit.setAuthData(
            email: _emailController.text,
            password: _passwordController.text,
          );
        }
        if (_signupCubit.state.currentPage <= widget._index) {
          _dataUpdated = false;
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          label: 'datos de autenticacion',
          formKey: widget._globalKey,
          children: <Widget>[
            TextInput(
              controller: _emailController,
              labelText: 'correo',
              validator: emailvalidator,
            ),
            Padding(
              padding: Constants.paddingTop,
              child: TextInput(
                controller: _passwordController,
                labelText: 'contraseña',
                isPassword: true,
                validator: passwordValidator,
              ),
            ),
            Padding(
              padding: Constants.paddingTop,
              child: TextInput(
                controller: _verifyPasswordController,
                labelText: 'repita la contraseña',
                isPassword: true,
                validator: (String? _) => comparePassword(
                  firstPassword: _passwordController.text,
                  secondPassword: _verifyPasswordController.text,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
