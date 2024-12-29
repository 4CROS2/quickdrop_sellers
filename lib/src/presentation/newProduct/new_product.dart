import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/functions/validators.dart';
import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/widgets/images_picker.dart';
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
          listener: (BuildContext context, NewProductState state) {
            if (state.status == NewProductStatus.error) {
              AppToastification.showError(
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
                            textInputType: TextInputType.numberWithOptions(),
                            onChanged: (String value) => cubit.setPrice(
                              int.parse(value),
                            ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: Constants.mainBorderRadius,
                      clipBehavior: Clip.antiAlias,
                      color: Constants.secondaryColor,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          if (_formKey.currentState!.validate()) {
                            cubit.saveNewProduct();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Constants.borderValue * 2,
                            vertical: Constants.paddingValue,
                          ),
                          child: Text(
                            'registrar producto'.capitalize(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
