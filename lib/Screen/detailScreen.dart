import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/modules/screens/barber_type.dart';
import 'package:heart_toggle/heart_toggle.dart';
import 'booking page.dart';

var serviceList;

class DetailScreen extends StatefulWidget {
  final stylist;

  DetailScreen(this.stylist);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiRequests _apiRequests = ApiRequests();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getServices() async {
    _apiRequests.retrieveImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    Image.network(
                        '${ApiConstants.baseUrl}${widget.stylist['imageUrl']}',
                        fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                            Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // Image loaded successfully
                        return child;
                      } else {
                        // Image is still loading
                        return const CircularProgressIndicator();
                      }
                    }),
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
                        ServiceTile(serviceList[0], widget.stylist['id']),
                        ServiceTile(serviceList[1], widget.stylist['id']),
                        ServiceTile(serviceList[2], widget.stylist['id']),
                        ServiceTile(serviceList[3], widget.stylist['id']),
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
                        height: MediaQuery.of(context).size.height / 6 + 20,
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
                              child: Image.network(
                                  '${ApiConstants.baseUrl}${widget.stylist['imageUrl']}',
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image loaded successfully
                                  return child;
                                } else {
                                  // Image is still loading
                                  return const CircularProgressIndicator();
                                }
                              }),
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
                          Text(
                            widget.stylist['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.stylist['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
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
                                widget.stylist['rating'].toString(),
                                style: const TextStyle(
                                  color: Color(0xffFF8573),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${widget.stylist['rating'].toString()})', //rateAmount
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
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

class ServiceTile extends StatelessWidget {
  final service;
  final int barberId;
  ServiceTile(this.service, this.barberId);

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
                  service['title'],
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
                '${service['duration']} Min',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            '\$${service['price']}',
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
                      builder: (context) => BookingPage(barberId: barberId)));
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
