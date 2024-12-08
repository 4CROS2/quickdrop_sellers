import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_input.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';

class EstablishmentInformation extends StatefulWidget {
  const EstablishmentInformation({
    required int index,
    required GlobalKey<FormState> globalkey,
    super.key,
  })  : _globalKey = globalkey,
        _index = index;

  final int _index;
  final GlobalKey<FormState>? _globalKey;
  @override
  State<EstablishmentInformation> createState() =>
      _EstablishmentInformationState();
}

class _EstablishmentInformationState extends State<EstablishmentInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (BuildContext context, SignupState state) {
        if (state.currentPage > widget._index) {
          context.read<SignupCubit>().setEstableshmentData();
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          formKey: widget._globalKey,
          label: 'informacion del establecimiento',
          children: <Widget>[
            AuthInput(
              labelText: 'razon social',
            ),
          ],
        );
      },
    );
  }
}
