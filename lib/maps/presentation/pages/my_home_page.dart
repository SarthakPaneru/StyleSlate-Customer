import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamro_barber_mobile/maps/data/barber_datasource.dart';
import 'package:hamro_barber_mobile/maps/data/datasources/repositories/barber_repository_impl.dart';
import 'package:hamro_barber_mobile/maps/data/datasources/repositories/location_repository_impl.dart';
import 'package:hamro_barber_mobile/maps/presentation/pages/widgets/draggable_sheet.dart';

import '../../data/datasources/location_datasource.dart';
import '../../domain/usecases/get_barber_location.dart';
import '../../domain/usecases/get_current_location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();
  final GetCurrentLocation _getCurrentLocation =
      GetCurrentLocation(LocationRepositoryImpl(LocationDataSource()));
  final GetBarberLocation _getBarberLocation =
      GetBarberLocation(BarberRepositoryImpl(BarberDataSource()));
  LatLng? _currentPosition;
  LatLng? _barberPosition;
  String _currentAddress = "Fetching location...";
  String _barberAddress = "Fetching barber location...";
  BitmapDescriptor? _barberIcon;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _fetchLocations();
    _loadCustomMarker();
  }

  Future<void> _fetchLocations() async {
    try {
      final currentLocation = await _getCurrentLocation();
      final barberLocation = await _getBarberLocation();
      setState(() {
        _currentPosition = currentLocation.position;
        _barberPosition = barberLocation.position;
        _currentAddress = currentLocation.address;
        _barberAddress = barberLocation.address;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadCustomMarker() async {
    _barberIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'lib/assets/images/barber_marker.png',
    );
  }

  Set<Polygon> _createPolygon() {
    if (_currentPosition != null && _barberPosition != null) {
      return {
        Polygon(
          polygonId: PolygonId("distancePolygon"),
          points: [_currentPosition!, _barberPosition!],
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.2),
        ),
      };
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Maps"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              if (_currentPosition != null)
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: _currentPosition!,
                  infoWindow: InfoWindow(title: "Your Location"),
                ),
              if (_barberPosition != null && _barberIcon != null)
                Marker(
                  markerId: MarkerId("barberLocation"),
                  position: _barberPosition!,
                  infoWindow: InfoWindow(title: "Barber Location"),
                  icon: _barberIcon!,
                ),
            },
            polygons: _createPolygon(),
          ),
          DraggableScrollableSheetWidget(
              sheetController: sheetController,
              currentAddress: _currentAddress,
              barberAddress: _barberAddress),
        ],
      ),
    );
  }
}
