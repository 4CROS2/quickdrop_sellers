import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/widgets/date_sellector.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/widgets/document_type.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_input.dart';

class SellerDataPage extends StatefulWidget {
  const SellerDataPage({
    required int index,
    GlobalKey<FormState>? globalKey,
    super.key,
  })  : _globalKey = globalKey,
        _index = index;
  final GlobalKey<FormState>? _globalKey;
  final int _index;

  @override
  State<SellerDataPage> createState() => _SellerDataPageState();
}

class _SellerDataPageState extends State<SellerDataPage> {
  late final List<TextEditingController> _textEditingControllers;
  late final SignupCubit _signupCubit;
  String _documentType = '';
  String _sellerDate = '';
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
          _signupCubit.setSellerData(
            name: _textEditingControllers[0].text,
            lastName: _textEditingControllers[1].text,
            documentType: _documentType,
            id: _textEditingControllers[2].text,
            date: _sellerDate,
            phone: _textEditingControllers[3].text,
          );
        }
        if (_signupCubit.state.currentPage <= widget._index) {
          _dataUpdated = false;
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          formKey: widget._globalKey,
          label: 'tus datos',
          children: <Widget>[
            InputText(
              controller: _textEditingControllers[0],
              validator: emptyValidator,
              labelText: 'nombre',
            ),
            InputText(
              controller: _textEditingControllers[1],
              validator: emptyValidator,
              labelText: 'apelidos',
            ),
            DocumentType(
              onSelected: (String? value) {
                if (value == null) {
                  return;
                }
                setState(() => _documentType = value);
              },
            ),
            InputText(
              controller: _textEditingControllers[2],
              validator: emptyValidator,
              labelText: 'numero de documento',
              textInputType: TextInputType.numberWithOptions(),
            ),
            DateSellector(onSelected: (String? value) {
              if (value == null) {
                return;
              }
              setState(() => _sellerDate = value);
            }),
            InputText(
              controller: _textEditingControllers[3],
              validator: emptyValidator,
              labelText: 'numero de contacto',
              textInputType: TextInputType.numberWithOptions(),
            ),
          ],
        );
      },
    );
  }
}
