import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/widgets/store_map_selection.dart';
import 'package:quickdrop_sellers/src/presentation/auth/widgets/auth_page.dart';
import 'package:quickdrop_sellers/src/presentation/location/cubit/location_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/text_area.dart';

class StoreLocationPage extends StatefulWidget {
  const StoreLocationPage({
    required int index,
    GlobalKey<FormState>? globalKey,
    super.key,
  })  : _globalKey = globalKey,
        _index = index;

  final int _index;
  final GlobalKey<FormState>? _globalKey;

  @override
  State<StoreLocationPage> createState() => _StoreLocationPageState();
}

class _StoreLocationPageState extends State<StoreLocationPage> {
  late final SignupCubit _signupCubit;
  late final LocationCubit _locationCubit;
  late final TextEditingController _directionController;
  late final TextEditingController _adicionalInformationController;
  late final MapController _mapController;
  late LatLng position;
  bool _dataUpdated = false;
  Marker? marker;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _signupCubit = context.read<SignupCubit>();
    _locationCubit = sl<LocationCubit>();
    _getCurrentLocation();
    _directionController = TextEditingController();
    _adicionalInformationController = TextEditingController();
  }

  void _setMark({required LatLng point}) async {
    setState(
      () {
        position = point;
        marker = Marker(
          point: point,
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40,
          ),
        );
      },
    );

    final List<Placemark> response =
        await placemarkFromCoordinates(point.latitude, point.longitude);
    if (response.isNotEmpty) {
      final Placemark place = response.first;
      setState(() {
        _directionController.text =
            '${place.street}, ${place.locality}, ${place.country}';
      });
    }
  }

  void _getCurrentLocation() async {
    await _locationCubit.getLocation();
    if (_locationCubit.state is Success) {
      final LocationData location = (_locationCubit.state as Success).location;
      _setMark(
        point: LatLng(location.latitude!, location.longitude!),
      );
      _mapController.move(position, 15);
    }
  }

  @override
  void dispose() {
    _directionController.dispose();
    _adicionalInformationController.dispose();
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
          _signupCubit.setStoreLocation(
            direction: _directionController.text,
            aditionalInformation: _adicionalInformationController.text,
            position: position,
          );
        } else if (_signupCubit.state.currentPage <= widget._index) {
          _dataUpdated = false;
        }
      },
      builder: (BuildContext context, SignupState state) {
        return AuthPage(
          formKey: widget._globalKey,
          label: 'ubicacion del establecimiento',
          children: <Widget>[
            StoreMapSelection(
              getPosition: () {
                _getCurrentLocation();
              },
              mapController: _mapController,
              setMark: (TapPosition tapPosition, LatLng point) {
                _setMark(point: point);
              },
              marker: marker,
            ),
            TextFormField(
              controller: _directionController,
              validator: (String? value) {
                if (value == '') {
                  return 'agrega una direccion';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'direccion'.capitalize(),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextArea(
              controller: _adicionalInformationController,
              label: 'informacion adicional ( opcional )',
            )
          ],
        );
      },
    );
  }
}
