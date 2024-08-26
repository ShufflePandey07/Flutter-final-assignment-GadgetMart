// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
// import 'package:flutter/material.dart';

// class MyCard extends StatelessWidget {
//   const MyCard({
//     super.key,
//     required this.gadgetEntity,
//     required this.onpressed,
//   });

//   final GadgetEntity gadgetEntity;
//   final VoidCallback onpressed;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Card(
//         child: SingleChildScrollView(
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 88,
//                 child: AspectRatio(
//                   aspectRatio: 0.88,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF5F6F9),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Image.network(
//                         '${ApiEndPoints.productImage}${gadgetEntity.productImage}'),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 20),
//               SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       gadgetEntity.productName,
//                       style: const TextStyle(color: Colors.black, fontSize: 14),
//                       maxLines: 2,
//                     ),
//                     const SizedBox(height: 8),
//                     Text.rich(
//                       TextSpan(
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600, color: Colors.amber),
//                         children: [
//                           TextSpan(
//                               text: "${gadgetEntity.productPrice}",
//                               style: Theme.of(context).textTheme.bodyLarge),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () => {
//                   // Add to cart

//                   onpressed()
//                 },
//                 child: const Text('Add to cart'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
