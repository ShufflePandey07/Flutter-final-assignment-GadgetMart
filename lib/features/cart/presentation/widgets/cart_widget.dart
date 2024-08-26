// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
// import 'package:final_assignment/features/cart/presentation/state/cart_state.dart';
// import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';

// class CartView extends ConsumerStatefulWidget {
//   const CartView({super.key});

//   @override
//   ConsumerState<CartView> createState() => _CartViewState();
// }

// class _CartViewState extends ConsumerState<CartView> {
//   String _selectedPaymentMethod = 'cash'; // Default to cash on delivery

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(
//         () => ref.read(cartViewModelProvider.notifier).fetchCart());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartState = ref.watch(cartViewModelProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.purple.shade800,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: cartState.items.isEmpty
//                   ? _buildEmptyCartView()
//                   : _buildCartItemsList(cartState),
//             ),
//             if (cartState.items.isNotEmpty)
//               _buildOrderSummaryAndCheckout(cartState),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyCartView() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.shopping_cart_outlined,
//               size: 100, color: Colors.purple.shade200),
//           const SizedBox(height: 20),
//           Text(
//             'Your cart is empty',
//             style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // Navigate to shop or home page
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple.shade800,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30)),
//             ),
//             child: const Text('Start Shopping', style: TextStyle(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartItemsList(CartState cartState) {
//     return ListView.builder(
//       itemCount: cartState.items.length,
//       itemBuilder: (context, index) {
//         return CartItem(
//           cartEntity: cartState.items[index],
//           onIncrement: () => _incrementItemQuantity(cartState.items[index]),
//           onDecrement: () => _decrementItemQuantity(cartState.items[index]),
//           onRemove: () => _removeFromCart(cartState.items[index]),
//         );
//       },
//     );
//   }

//   Widget _buildOrderSummaryAndCheckout(CartState cartState) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           OrderSummary(
//             items: cartState.totalItems,
//             subtotal: cartState.subtotal.toInt(),
//             deliveryCharge: 50,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Select Payment Method:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 _buildPaymentOption('Cash on Delivery', 'cash'),
//                 _buildPaymentOption('Pay with Khalti', 'khalti'),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () => _handleCheckout(cartState),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.purple.shade800,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   child: const Text(
//                     'Checkout',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentOption(String title, String value) {
//     return RadioListTile<String>(
//       title: Text(title),
//       value: value,
//       groupValue: _selectedPaymentMethod,
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedPaymentMethod = newValue!;
//         });
//       },
//       activeColor: Colors.purple.shade800,
//     );
//   }

//   void _handleCheckout(CartState cartState) {
//     if (_selectedPaymentMethod == 'cash') {
//       // Handle cash on delivery
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Order placed successfully! Cash on delivery.'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       ref.read(cartViewModelProvider.notifier).clearCart();
//     } else if (_selectedPaymentMethod == 'khalti') {
//       _payWithKhalti(cartState);
//     }
//   }

//   void _incrementItemQuantity(CartEntity cartEntity) {
//     ref.read(cartViewModelProvider.notifier).incrementItemQuantity(
//         cartEntity.id!, cartEntity.gadgetEntity.productPrice);
//   }

//   void _decrementItemQuantity(CartEntity cartEntity) {
//     ref.read(cartViewModelProvider.notifier).decrementItemQuantity(
//         cartEntity.id!, cartEntity.gadgetEntity.productPrice);
//   }

//   void _removeFromCart(CartEntity cartEntity) {
//     ref.read(cartViewModelProvider.notifier).removeFromCart(cartEntity.id!);
//   }

//   void _payWithKhalti(CartState cartState) {
//     final config = PaymentConfig(
//       amount: cartState.subtotal.toInt() * 100,
//       productIdentity: 'cart-items',
//       productName: 'Cart Items',
//       productUrl: 'https://yourwebsite.com/products',
//       additionalData: {
//         'notes': 'Payment for cart items',
//       },
//     );
//     KhaltiScope.of(context).pay(
//       config: config,
//       preferences: [
//         PaymentPreference.khalti,
//       ],
//       onSuccess: (successModel) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Payment Successful!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       },
//       onFailure: (failureModel) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Payment Failed!'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       },
//       onCancel: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Payment Cancelled!'),
//             backgroundColor: Colors.orange,
//           ),
//         );
//       },
//     );
//   }
// }

// class CartItem extends StatelessWidget {
//   final CartEntity cartEntity;
//   final VoidCallback onIncrement;
//   final VoidCallback onDecrement;
//   final VoidCallback onRemove;

//   const CartItem({
//     super.key,
//     required this.cartEntity,
//     required this.onIncrement,
//     required this.onDecrement,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: Key(cartEntity.id.toString()),
//       direction: DismissDirection.endToStart,
//       onDismissed: (_) => onRemove(),
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         color: Colors.red,
//         child: const Icon(Icons.delete, color: Colors.white),
//       ),
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   '${ApiEndPoints.productImage}${cartEntity.gadgetEntity.productImage}',
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       cartEntity.gadgetEntity.productName,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Rs ${cartEntity.total}',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.purple.shade800,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.remove_circle_outline),
//                           onPressed: onDecrement,
//                           color: Colors.red,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 4),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             '${cartEntity.quantity}',
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.add_circle_outline),
//                           onPressed: onIncrement,
//                           color: Colors.green,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OrderSummary extends StatelessWidget {
//   final int items;
//   final int subtotal;
//   final int deliveryCharge;

//   const OrderSummary({
//     super.key,
//     required this.items,
//     required this.subtotal,
//     required this.deliveryCharge,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Order Summary',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.purple.shade800)),
//           const SizedBox(height: 16),
//           _buildSummaryRow('Items', items.toString()),
//           _buildSummaryRow('Subtotal', 'Rs $subtotal'),
//           _buildSummaryRow('Delivery Charge', 'Rs $deliveryCharge'),
//           const Divider(height: 24, thickness: 1),
//           _buildSummaryRow('Total', 'Rs ${subtotal + deliveryCharge}',
//               isTotal: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontSize: isTotal ? 18 : 16,
//                   fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
//           Text(value,
//               style: TextStyle(
//                   fontSize: isTotal ? 18 : 16,
//                   fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//                   color: isTotal ? Colors.purple.shade800 : Colors.black)),
//         ],
//       ),
//     );
//   }
// }
