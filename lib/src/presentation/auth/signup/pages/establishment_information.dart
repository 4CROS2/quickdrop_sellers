import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/functions/rut_verification.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/separated_input.dart';
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

  @override
  void initState() {
    super.initState();
    _textEditingControllers = List<TextEditingController>.generate(
      5,
      (int index) {
        return TextEditingController();
      },
    );
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
        if (state.currentPage > widget._index) {
          context.read<SignupCubit>().setEstableshmentData(
                companyName: _textEditingControllers[0].text,
                rut: _textEditingControllers[1].text,
                description: _textEditingControllers[2].text,
                direction: _textEditingControllers[3].text,
                contact: _textEditingControllers[4].text,
              );
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          formKey: widget._globalKey,
          label: 'información del establecimiento',
          children: <Widget>[
            TextInput(
              labelText: 'razón social',
              controller: _textEditingControllers[0],
              validator: emptyValidator,
            ),
            SeparatedInput(
              child: TextInput(
                controller: _textEditingControllers[1],
                labelText: 'RUT*',
                textInputType: TextInputType.numberWithOptions(
                  decimal: false,
                ),
                validator: validateRUT,
              ),
            ),
            SeparatedInput(
              child: TextArea(
                controller: _textEditingControllers[2],
                label: 'descripcion del establecimiento',
              ),
            ),
            SeparatedInput(
              child: TextInput(
                controller: _textEditingControllers[3],
                labelText: 'Direccion',
                textInputType: TextInputType.numberWithOptions(
                  decimal: false,
                ),
              ),
            ),
            SeparatedInput(
              child: TextInput(
                controller: _textEditingControllers[4],
                labelText: 'numero de contacto',
                textInputType: TextInputType.numberWithOptions(
                  decimal: false,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SeparatedInput(
                child: Text(
                  '*En caso de no tener rut dejar el campo vacío',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}