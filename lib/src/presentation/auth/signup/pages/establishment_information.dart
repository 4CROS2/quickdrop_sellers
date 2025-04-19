import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/functions/rut_verification.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_area.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_input.dart';

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
  late final List<TextEditingController> _textEditingControllers;
  late final SignupCubit _signupCubit;
  bool _dataUpdated = false;

  @override
  void initState() {
    super.initState();
    _textEditingControllers = List<TextEditingController>.generate(
      4,
      (int index) {
        return TextEditingController();
      },
    );
    _signupCubit = context.read<SignupCubit>();
  }

  @override
  void dispose() {
    for (TextEditingController controller in _textEditingControllers) {
      controller.dispose();
    }
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
          _signupCubit.setEstableshmentData(
            companyName: _textEditingControllers[0].text,
            rut: _textEditingControllers[1].text,
            description: _textEditingControllers[2].text,
            contact: _textEditingControllers[3].text,
          );
        } else if (_signupCubit.state.currentPage <= widget._index) {
          _dataUpdated = false;
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          formKey: widget._globalKey,
          label: 'información del establecimiento',
          children: <Widget>[
            InputText(
              labelText: 'razón social',
              controller: _textEditingControllers[0],
              validator: emptyValidator,
            ),
            InputText(
              controller: _textEditingControllers[1],
              labelText: 'RUT*',
              textInputType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
              validator: validateRUT,
            ),
            TextArea(
              controller: _textEditingControllers[2],
              label: 'descripcion del establecimiento',
            ),
            InputText(
              controller: _textEditingControllers[3],
              labelText: 'numero de contacto',
              textInputType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '*En caso de no tener rut dejar el campo vacío',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
