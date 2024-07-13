import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentPage extends StatefulWidget {
  int amount, appointmentId;
  String serviceName;
  PaymentPage(
      {super.key,
      required this.amount,
      required this.appointmentId,
      required this.serviceName});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentConfig config;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    config = PaymentConfig(
      amount: widget.amount, // Amount in paisa
      productIdentity: widget.appointmentId.toString(),
      productName: widget.serviceName,
      productUrl: 'https://www.example.com',
      additionalData: {
        'vendor': 'Khalti Bazaar',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khalti Payment'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            KhaltiScope.of(context).pay(
              config: config,
              preferences: [
                PaymentPreference.khalti,
                PaymentPreference.eBanking,
              ],
              onSuccess: (successModel) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HomePage();
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Payment Successful: ${successModel.token}')),
                );
              },
              onFailure: (failureModel) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Payment Failed: ${failureModel.message}')),
                );
              },
              onCancel: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Cancelled')),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Text(
              'Pay with Khalti',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
