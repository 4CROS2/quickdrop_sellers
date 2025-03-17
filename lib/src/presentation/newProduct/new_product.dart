import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/positive_number_formatter.dart';
import 'package:quickdrop_sellers/src/core/extensions/text_input_type_extension.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/widgets/images_picker.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/widgets/pop_up_status.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/widgets/submit_new_product_button.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/widgets/tags_inputs.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_area.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_input.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/toastificastion.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  late final List<TextEditingController> _controllers;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _controllers = List<TextEditingController>.generate(
      5,
      (int index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'añadir producto'.capitalize(),
      ),
      body: BlocProvider<NewProductCubit>(
        create: (BuildContext context) => sl<NewProductCubit>(),
        child: BlocConsumer<NewProductCubit, NewProductState>(
          buildWhen: (NewProductState previous, NewProductState current) =>
              previous.status != current.status,
          listener: (BuildContext context, NewProductState state) {
            if (state.status == NewProductStatus.error) {
              AppToastification.showError(
                context: context,
                message: state.message,
              );
            }
            if (state.status == NewProductStatus.loading) {
              _showLoadingDialog(context);
            }
            if (state.status == NewProductStatus.success) {
              AppToastification.showSuccess(
                context: context,
                message: state.message,
              );
            }
          },
          builder: (BuildContext context, NewProductState state) {
            final NewProductCubit cubit = context.read<NewProductCubit>();
            return Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    padding: Constants.mainPadding,
                    physics: Constants.mainPhysics,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: Constants.paddingValue,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InputText(
                            labelText: 'nombre del producto',
                            controller: _controllers[0],
                            onChanged: cubit.setProductName,
                            validator: emptyValidator,
                          ),
                          InputText(
                            labelText: 'precio',
                            controller: _controllers[1],
                            validator: emptyValidator,
                            formatters: <TextInputFormatter>[
                              PositiveNumberFormatter()
                            ],
                            textInputType: TextInputTypeExtension.numbersOnly,
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                cubit.setPrice(
                                  int.parse(value),
                                );
                              }
                            },
                          ),
                          TextArea(
                            label: 'descripcion',
                            controller: _controllers[2],
                            validator: emptyValidator,
                            onChange: cubit.setDescription,
                          ),
                          ImagesPicker(),
                          TagsInputs(),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SubmitNewProductButton(
                    formKey: _formKey,
                    cubit: cubit,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    // Verificamos si ya existe un diálogo
    if (ModalRoute.of(context)?.isCurrent != true) {
      return;
    }

    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => PopUpStatus(
        context: context,
      ),
    );
  }
}
