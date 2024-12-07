import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/widgets/date_sellector.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/widgets/document_type.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_input.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (BuildContext context, SignupState state) {
        if (state.currentPage > widget._index) {
          context.read<SignupCubit>().setSellerData();
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          formKey: widget._globalKey,
          label: 'tus datos',
          children: <Widget>[
            AuthInput(
              validator: emptyValidator,
              labelText: 'nombre',
            ),
            _separatedInput(
              widget: AuthInput(
                validator: emptyValidator,
                labelText: 'apelidos',
              ),
            ),
            _separatedInput(
              widget: DocumentType(),
            ),
            _separatedInput(
              widget: AuthInput(
                validator: emptyValidator,
                labelText: 'numero de documento',
                textInputType: TextInputType.numberWithOptions(),
              ),
            ),
            _separatedInput(
              widget: DateSellector(),
            ),
            _separatedInput(
              widget: AuthInput(
                validator: emptyValidator,
                labelText: 'numero de contacto',
                textInputType: TextInputType.numberWithOptions(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _separatedInput({required Widget widget}) {
    return Padding(
      padding: Constants.paddingTop,
      child: widget,
    );
  }
}
