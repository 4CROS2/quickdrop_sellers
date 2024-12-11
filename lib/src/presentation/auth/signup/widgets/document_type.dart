import 'package:custom_dropdown_menu/custom_dropdown_menu.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class DocumentType extends StatefulWidget {
  const DocumentType({required void Function(String?) onSelected, super.key})
      : _onSelected = onSelected;
  final void Function(String?) _onSelected;

  @override
  State<DocumentType> createState() => _DocumentTypeState();
}

class _DocumentTypeState extends State<DocumentType> {
  final GlobalKey _locationKey = GlobalKey();
  String? _documentType;

  void _setDocumentType(String value) {
    setState(() {
      _documentType = value.capitalize();
    });
    widget._onSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: _locationKey,
      borderRadius: Constants.mainBorderRadius,
      clipBehavior: Clip.hardEdge,
      color: Constants.mainColor,
      child: InkWell(
        onTap: () {
          CustomDropdownMenu.showCustomMenu(
            context,
            widgetKey: _locationKey,
            options: <String>['cedula', 'tarjeta de identidad'],
            onSelected: _setDocumentType,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _documentType ?? 'Tipo de documento',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
