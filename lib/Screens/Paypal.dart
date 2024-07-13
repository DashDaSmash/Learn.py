import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaypalPayment extends StatefulWidget {
  const PaypalPayment({Key? key}) : super(key: key);

  @override
  _PaypalPaymentState createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  @override
  void initState() {
    super.initState();
    // Trigger the PayPal payment view here
    _showPaypalCheckoutView();
  }

  void _showPaypalCheckoutView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId:
              "AfyiT1_yt_KYXEsGLxB24ykIkvuF6KWSIPN0qSCRJH27saQvOAbVhVtMkg-X6zRtACwL5hQWAyOrTwVM",
          secretKey:
              "ENIvrEkeSpFwqv91SSnQkpNBilmHSN75PDW3naalINtgPGMqlsklDvyYqL0N10WHRZDpqa_Ks8MYRaxJ",
          transactions: const [
            {
              "amount": {
                "total": '100',
                "currency": "USD",
                "details": {
                  "subtotal": '100',
                  "shipping": '0',
                  "shipping_discount": 0,
                },
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "Apple",
                    "quantity": 4,
                    "price": '10',
                    "currency": "USD",
                  },
                  {
                    "name": "Pineapple",
                    "quantity": 5,
                    "price": '12',
                    "currency": "USD",
                  },
                ],
              },
            },
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map<String, dynamic> params) async {
            log("onSuccess: $params");
            Navigator.pop(context);
          },
          onError: (dynamic error) {
            log("onError: $error");
            Navigator.pop(context);
          },
          onCancel: () {
            print('Cancelled');
            Navigator.pop(context);
          },
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading PayPal payment gateway...'),
      ),
    );
  }
}
