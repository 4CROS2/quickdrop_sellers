import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';

class PopUpStatus extends StatefulWidget {
  const PopUpStatus({required BuildContext context, super.key})
      : _context = context;
  final BuildContext _context;

  @override
  State<PopUpStatus> createState() => _PopUpStatusState();
}

class _PopUpStatusState extends State<PopUpStatus> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider<NewProductCubit>.value(
        value: widget._context.read<NewProductCubit>(),
        child: BlocBuilder<NewProductCubit, NewProductState>(
          buildWhen: (NewProductState previous, NewProductState current) {
            if (current.status == NewProductStatus.success ||
                current.status == NewProductStatus.error) {
              widget._context.pop();
              widget._context.pop();
            }

            return previous.status == NewProductStatus.loading &&
                previous.message != current.message;
          },
          builder: (BuildContext context, NewProductState state) {
            return CupertinoAlertDialog(
              title: Text(state.message.capitalize()),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
