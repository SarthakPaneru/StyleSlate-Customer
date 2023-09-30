import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/modules/screens/barber_type.dart';
import 'package:heart_toggle/heart_toggle.dart';
import 'booking page.dart';
import 'package:http/http.dart' as http;

var serviceList;

class DetailScreen extends StatefulWidget {
  final int barberId;

  const DetailScreen({Key? key, required this.barberId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState(barberId);
}

class _DetailScreenState extends State<DetailScreen> {
  late int barberId;

  _DetailScreenState(this.barberId);

  final ApiRequests _apiRequests = ApiRequests();

  // List<Barber> barbershop = List.empty(growable: true);
  String _panNo = '';
  String _name = '';
  String? _phone = '';

  List<int> _servicesId = List.empty(growable: true);
  List<String> _servicesName = List.empty(growable: true);
  List<String> _servicesFee = List.empty(growable: true);
  List<String> _servicesTimeInMinutes = List.empty(growable: true);

  late double _rating;
  late int _lengthOfResponse;
  String _imageUrl = '';
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarber(barberId);
    // getBarberImage(barberId);
    getImageUrl();
  }

  void getBarberImage(int id) async {
    await _apiRequests.retrieveImageUrl();
  }

  Future<void> getBarber(int barberId) async {
    // await Future.delayed(Duration(seconds: 2));
    try {
      http.Response response = await _apiRequests.getBarber(barberId);
      print(response.body);

      final jsonResponse = jsonDecode(response.body);

      _panNo = jsonResponse['panNo'];
      _phone = jsonResponse['phone'];
      _name = jsonResponse['name'];
      _rating = jsonResponse['rating'];

      List<dynamic> services = jsonResponse['services'];
      _lengthOfResponse = services.length;

      print('length of response: $_lengthOfResponse');

      for (int i = 0; i < _lengthOfResponse; i++) {
        getService(services[i]);
      }

      setState(() {
        _lengthOfResponse = _lengthOfResponse;
        print('LENGTH OF RESPONSE: $_lengthOfResponse');
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImageUrl() async {
    String image = await _apiRequests.retrieveImageUrl();
    setState(() {
      _imageUrl = image;
    });
  }

  void getService(final service) {
    Map<String, dynamic> jsonResponseservice = jsonDecode(jsonEncode(service));
    int id = jsonResponseservice['id'];
    _servicesId.add(id);
    String serviceName = jsonResponseservice['serviceName'];
    _servicesName.add(serviceName);
    String fee = jsonResponseservice['fee'];
    _servicesName.add(fee);
    String duration = jsonResponseservice['serviceTimeInMinutes'];
    _servicesTimeInMinutes.add(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3 + 10,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: '${_imageUrl}',
                            placeholder: (context, url) => const Icon(
                              Icons.person,
                              size: 80,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.purple.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 30,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 140,
                              ),
                              const Text(
                                'Service List',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  ListView.builder(
                                    itemCount: _lengthOfResponse,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          ServiceTile(
                                            _servicesId[index],
                                            barberId,
                                            _servicesName[index],
                                            _servicesTimeInMinutes[index],
                                            _servicesFee[index],
                                          ),
                                        ],
                                      );
                                    },
                                    shrinkWrap: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3 - 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3 - 20,
                              height:
                                  MediaQuery.of(context).size.height / 6 + 20,
                              decoration: BoxDecoration(
                                color: const Color(0xffFFF0EB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Positioned(
                                    top: 5,
                                    right: -25,
                                    child: CachedNetworkImage(
                                      imageUrl: '${_imageUrl}',
                                      placeholder: (context, url) => const Icon(
                                        Icons.person,
                                        size: 80,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      _name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Color(0xffFF8573),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          _rating.toString(),
                                          style: const TextStyle(
                                            color: Color(0xffFF8573),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: MediaQuery.of(context).size.height / 3 - 55,
                      child: MaterialButton(
                          onPressed: () {},
                          padding: const EdgeInsets.all(10),
                          child: HeartToggle(
                            props: HeartToggleProps(
                              size: 35.0,
                              passiveFillColor: Colors.grey[200]!,
                              ballElevation: 4.0,
                              heartElevation: 4.0,
                              ballColor: Colors.white,
                              onChanged: (toggled) => {},
                            ),
                          )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ServiceTile extends StatefulWidget {
  final int serviceId;
  final int barberId;
  final String serviceName;
  final String serviceTimeInMinutes;
  final String price;

  const ServiceTile(this.serviceId, this.barberId, this.serviceName,
      this.serviceTimeInMinutes, this.price, {super.key});

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: Text(
                  widget.serviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${widget.serviceTimeInMinutes} Min',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            widget.price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingPage(
                            barberId: widget.barberId,
                            serviceId: widget.serviceId,
                          )));
            },
            color: const Color(0xffFF8573),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Book',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
