import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:heart_toggle/heart_toggle.dart';
import 'package:http/http.dart' as http;

import 'booking page.dart';

class DetailScreen extends StatefulWidget {
  final int barberId;

  const DetailScreen({Key? key, required this.barberId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiRequests _apiRequests = ApiRequests();
  String _panNo = '';
  String _name = '';
  String? _phone = '';
  final List<int> _servicesId = [];
  final List<String> _servicesName = [];
  final List<String> _servicesFee = [];
  final List<String> _servicesTimeInMinutes = [];
  late double _rating;
  late int _lengthOfResponse;
  String _imageUrl = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getBarber(widget.barberId);
    getImageUrl();
  }

  Future<void> getBarber(int barberId) async {
    try {
      http.Response response = await _apiRequests.getBarber(barberId);
      final jsonResponse = jsonDecode(response.body);

      _panNo = jsonResponse['panNo'];
      _phone = jsonResponse['phone'];
      _name = jsonResponse['name'];
      _rating = jsonResponse['rating'].toDouble();

      List<dynamic> services = jsonResponse['services'];
      _lengthOfResponse = services.length;

      for (int i = 0; i < _lengthOfResponse; i++) {
        getService(services[i]);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> getImageUrl() async {
    String image = await _apiRequests.retrieveImageUrl();
    setState(() {
      _imageUrl = image;
    });
  }

  void getService(final service) {
    Map<String, dynamic> jsonResponseService = jsonDecode(jsonEncode(service));
    int id = jsonResponseService['id'];
    _servicesId.add(id);
    String serviceName = jsonResponseService['serviceName'];
    _servicesName.add(serviceName);
    String fee = jsonResponseService['fee'];
    _servicesFee.add(fee);
    String duration = jsonResponseService['serviceTimeInMinutes'];
    _servicesTimeInMinutes.add(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xffbfa58c)))
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: const Color(0xff323345),
                  expandedHeight: 300,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(_name,
                        style: TextStyle(
                          color: Color(0xffbfa58c),
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        )),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: _imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xffbfa58c)),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 80,
                            color: Color(0xffbfa58c),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xff323345).withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    HeartToggle(
                      props: HeartToggleProps(
                        size: 35.0,
                        passiveFillColor: Colors.white,
                        activeFillColor: Color(0xffbfa58c),
                        ballElevation: 4.0,
                        heartElevation: 4.0,
                        ballColor: Colors.white,
                        onChanged: (toggled) => {},
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xffbfa58c)),
                            SizedBox(width: 8),
                            Text(
                              _rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Contact: $_phone',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffbfa58c),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ServiceTile(
                          _servicesId[index],
                          widget.barberId,
                          _servicesName[index],
                          _servicesTimeInMinutes[index],
                          _servicesFee[index],
                        ),
                      );
                    },
                    childCount: _lengthOfResponse,
                  ),
                ),
              ],
            ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final int serviceId;
  final int barberId;
  final String serviceName;
  final String serviceTimeInMinutes;
  final String price;

  const ServiceTile(this.serviceId, this.barberId, this.serviceName,
      this.serviceTimeInMinutes, this.price,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Color(0xff424560),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$serviceTimeInMinutes Min',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xffbfa58c),
                  ),
                ),
                SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(
                          barberId: barberId,
                          serviceId: serviceId,
                        ),
                      ),
                    );
                  },
                  child: Text('Book'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xff323345),
                    backgroundColor: Color(0xffbfa58c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
