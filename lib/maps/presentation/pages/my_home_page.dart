import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamro_barber_mobile/maps/data/barber_datasource.dart';
import 'package:hamro_barber_mobile/maps/data/datasources/repositories/barber_repository_impl.dart';
import 'package:hamro_barber_mobile/maps/data/datasources/repositories/location_repository_impl.dart';
import 'package:hamro_barber_mobile/maps/presentation/pages/widgets/draggable_sheet.dart';
import 'package:http/http.dart' as http;

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
  Set<Polyline> _polylines = {};
  double _remainingDistance = 0.0;
  StreamSubscription<Position>? _positionStream;
  bool _mapLoaded = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
    _loadCustomMarker();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _loadCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _mapLoaded = true;
      });
      _fetchLocations();
      _startLocationUpdates();
    } catch (e) {
      print('Error getting current location: $e');
    }
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
      await _fetchRoute();
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> _loadCustomMarker() async {
    final ImageConfiguration imageConfiguration =
        ImageConfiguration(devicePixelRatio: 2.5);
    _barberIcon = await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'lib/assets/images/barber_marker.png',
    );
  }

  Future<void> _fetchRoute() async {
    if (_currentPosition == null || _barberPosition == null) return;

    final String apiKey =
        'AIzaSyAjCmOXQeND-9TeJjUuVb7tV1nfsD2rBwo'; // Replace with your Google API key
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${_barberPosition!.latitude},${_barberPosition!.longitude}&mode=driving&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final routes = json['routes'] as List;
      if (routes.isNotEmpty) {
        final points = routes[0]['overview_polyline']['points'];
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: _decodePolyline(points),
            color: Colors.blue,
            width: 5,
          ),
        );
        final legs = routes[0]['legs'] as List;
        if (legs.isNotEmpty) {
          _remainingDistance =
              legs[0]['distance']['value'] / 1000.0; // in kilometers
        }
        setState(() {});
      }
    } else {
      print('Failed to load directions');
    }
  }

  void _startLocationUpdates() {
    _positionStream = Geolocator.getPositionStream(
//desiredAccuracy: LocationAccuracy.high,
            //    distanceFilter: 10, // meters
            )
        .listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      _fetchRoute();
    });
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      appBar: AppBar(
        backgroundColor: const Color(0xff323345),
        title: const Text("Maps"),
      ),
      body: Stack(
        children: [
          if (_mapLoaded)
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _currentPosition != null
                  ? CameraPosition(target: _currentPosition!, zoom: 14.0)
                  : _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: {
                if (_currentPosition != null)
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: _currentPosition!,
                    infoWindow: const InfoWindow(title: "Your Location"),
                  ),
                if (_barberPosition != null && _barberIcon != null)
                  Marker(
                    markerId: const MarkerId("barberLocation"),
                    position: _barberPosition!,
                    infoWindow: const InfoWindow(title: "Barber Location"),
                    icon: _barberIcon!,
                  ),
              },
              polylines: _polylines,
            ),
          DraggableScrollableSheetWidget(
            sheetController: sheetController,
            currentAddress: _currentAddress,
            barberAddress: _barberAddress,
            remainingDistance: _remainingDistance,
          ),
        ],
      ),
    );
  }
}
