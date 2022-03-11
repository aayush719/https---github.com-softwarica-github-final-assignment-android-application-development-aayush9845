// import 'package:flutter/material.dart';
// import 'package:khalti/khalti.dart';
// import 'package:url_launcher/url_launcher.dart' as url_launcher;

// class KhaltiPaymentPage extends StatefulWidget {
//   const KhaltiPaymentPage({Key? key}) : super(key: key);
//   @override
//   State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
// }

// class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
//   TextEditingController amountController = TextEditingController();
//   getAmt() {
//     return int.parse(amountController.text) * 100; // Converting to paisa
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Khalti Payment Integration'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(15),
//         child: ListView(
//           children: [
//             const SizedBox(height: 15),
//             // For Amount
//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                   labelText: "Enter Amount to pay",
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                     borderRadius: BorderRadius.all(Radius.circular(8)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.green),
//                     borderRadius: BorderRadius.all(Radius.circular(8)),
//                   )),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             // For Button
//             MaterialButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     side: const BorderSide(color: Colors.red)),
//                 height: 50,
//                 color: const Color(0xFF56328c),
//                 child: const Text(
//                   'Pay With Khalti',
//                   style: TextStyle(color: Colors.white, fontSize: 22),
//                 ),
//                 onPressed: () {
//                   KhaltiScope.of(context).pay(
//                     config: PaymentConfig(
//                       amount: getAmt(),
//                       productIdentity: 'KaliJStore',
//                       productName: 'The Rhino Sport and The Game Farm',
//                     ),
//                     preferences: [
//                       PaymentPreference.khalti,
//                     ],
//                     onSuccess: (su) {
//                       const successsnackBar = SnackBar(
//                         content: Text('Payment Successful'),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(successsnackBar);
//                     },
//                     onFailure: (fa) {
//                       const failedsnackBar = SnackBar(
//                         content: Text('Payment Failed'),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(failedsnackBar);
//                     },
//                     onCancel: () {
//                       const cancelsnackBar = SnackBar(
//                         content: Text('Payment Cancelled'),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(cancelsnackBar);
//                     },
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
