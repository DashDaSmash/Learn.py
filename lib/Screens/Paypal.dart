import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:learn_py/Objects/GenericButton.dart';
import 'package:learn_py/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PaypalPayment extends StatefulWidget {
  const PaypalPayment({Key? key}) : super(key: key);

  @override
  _PaypalPaymentState createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
  bool donationComplete = false;

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
                "total": '5',
                "currency": "USD",
                "details": {
                  "subtotal": '5',
                  "shipping": '0',
                  "shipping_discount": 0,
                },
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "Donation",
                    "quantity": 1,
                    "price": '5',
                    "currency": "USD",
                  },
                ],
              },
            },
          ],
          note: "Contact us for any questions on your payment.",
          onSuccess: (Map<String, dynamic> params) async {
            log("onSuccess: $params");
            Navigator.pop(context);
            setState(() {
              donationComplete = true;
            });
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: donationComplete
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Image.asset('assets/donation.gif'),
                    GenericButton(
                        label: 'Continue',
                        function: () {
                          Navigator.pop(context);
                        },
                        type: GenericButtonType.proceed)
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    Column(
                      children: [
                        LoadingAnimationWidget.threeRotatingDots(
                          color: Color(0xFF80FE94), // Set your desired color
                          size: 100.0, // Set the size of the animation
                        ),
                        Center(
                          child: Text('Loading PayPal payment gateway...'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GenericButton(
                          label: 'Try again',
                          function: () {
                            _showPaypalCheckoutView();
                          },
                          type: GenericButtonType.semiProceed,
                          width: 200,
                        ),
                      ],
                    ),
                    GenericButton(
                        label: 'Back',
                        function: () {
                          Navigator.pop(context);
                        },
                        type: GenericButtonType.generic)
                  ],
                ),
        ),
      ),
    );
  }
}
