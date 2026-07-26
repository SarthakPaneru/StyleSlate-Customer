import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_strings.dart';
import 'package:hamro_barber_mobile/modules/screens/homepage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.khaltiPaymentTitle),
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
                      content: Text(AppStrings.khaltiPaymentSuccessful(
                          successModel.token))),
                );
              },
              onFailure: (failureModel) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(AppStrings.khaltiPaymentFailed(
                          failureModel.message))),
                );
              },
              onCancel: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.khaltiPaymentCancelled)),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Text(
              AppStrings.khaltiPayWithKhalti,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
