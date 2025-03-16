import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class StoreMapSelection extends StatefulWidget {
  const StoreMapSelection({
    void Function(
      TapPosition tapPosition,
      LatLng point,
    )? setMark,
    Marker? marker,
    super.key,
  })  : _setMark = setMark,
        _marker = marker;

  final void Function(
    TapPosition tapPosition,
    LatLng point,
  )? _setMark;

  final Marker? _marker;

  @override
  State<StoreMapSelection> createState() => _StoreMapSelectionState();
}

class _StoreMapSelectionState extends State<StoreMapSelection> {
  bool mapActive = false;
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void enableMap() {
    setState(() {
      mapActive = !mapActive;
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: Constants.mainBorderRadius,
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Stack(
          children: <Widget>[
            IgnorePointer(
              ignoring: !mapActive,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(5.157472, -76.686976),
                  initialZoom: 15.8,
                  maxZoom: 22,
                  interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                  onTap: widget._setMark,
                ),
                children: <Widget>[
                  TileLayer(
                    urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}@4x.png',
                    subdomains: <String>['a', 'b', 'c'],
                    userAgentPackageName: 'com.crossdev.quickdrop_sellers',
                    retinaMode: true,
                  ),
                  MarkerLayer(
                    markers: widget._marker != null
                        ? <Marker>[widget._marker!]
                        : <Marker>[],
                  ),
                ],
              ),
            ),
            if (mapActive)
              Positioned(
                bottom: 50 + Constants.paddingValue * 1.5,
                right: Constants.paddingValue * 1.45,
                child: Material(
                  color: Constants.mainColor,
                  borderRadius: Constants.mainBorderRadius * .5,
                  child: InkWell(
                    onTap: () {
                      _mapController.move(LatLng(5.157472, -76.686976), 17);
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.my_location_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: Constants.paddingValue,
              right: Constants.paddingValue,
              child: Material(
                color: Constants.secondaryColor,
                clipBehavior: Clip.antiAlias,
                borderRadius: Constants.mainBorderRadius * .5,
                child: InkWell(
                  onTap: enableMap,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: AnimatedSwitcher(
                      duration: Constants.mainDuration,
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        key: Key(mapActive.toString()),
                        !mapActive
                            ? Icons.edit_location_alt_outlined
                            : Icons.check_circle_outline_rounded,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
