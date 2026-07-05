import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/features/home/home_shell_view.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentPage extends StatelessWidget {
  final PaymentConfig config = PaymentConfig(
    amount: 10000, // Amount in paisa
    productIdentity: 'dell-g5-g5510-2021',
    productName: 'Dell G5 G5510 2021',
    productUrl: 'https://www.example.com',
    additionalData: {
      'vendor': 'Khalti Bazaar',
    },
  );

  PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalti Payment'),
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
                      return const HomeShellView();
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
                  const SnackBar(content: Text('Payment Cancelled')),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue,
            child: const Text(
              'Pay with Khalti',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
