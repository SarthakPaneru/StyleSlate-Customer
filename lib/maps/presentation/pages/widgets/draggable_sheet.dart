import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DraggableScrollableSheetWidget extends StatelessWidget {
  final DraggableScrollableController sheetController;
  final String currentAddress;
  final String barberAddress;
  final double remainingDistance;

  const DraggableScrollableSheetWidget({
    Key? key,
    required this.sheetController,
    required this.currentAddress,
    required this.barberAddress,
    required this.remainingDistance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: sheetController,
      builder: (BuildContext context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color(0xff323345),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    FilledButton.tonal(
                      onPressed: () {
                        sheetController.animateTo(
                          0.8,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: const Text('Scroll to 0.8'),
                    ),
                    ListTile(
                      title: Text(
                        'Current Location: $currentAddress',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Barber Location: $barberAddress',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Distance: ${remainingDistance.toStringAsFixed(1)} km',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'To get accurate location, click the button below:',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Get Accurate Direction'),
                                content: Text('You are leaving this app.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss alert
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final url =
                                          'https://www.google.com/maps/dir/?api=1&destination=${barberAddress.replaceAll(' ', '+')}';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue, // Background color of the button
                        ),
                        child: Text('Click Here'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
