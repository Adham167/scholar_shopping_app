// صفحة جديدة orders_history.dart
import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/screens/order_details.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
import 'package:scholar_shopping_app/widgets/empty_widget.dart';

class OrdersHistory extends StatelessWidget {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body:
          orderHistory.isEmpty
              ? const EmptyWidget(
                message1: "No Orders yet",
                message2: "Your Order History will appear here",
                message3: "Start Shopping",
                iconData: Icons.list_alt,
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetails(order: order),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #${order.orderId.substring(0, 6)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(order.formattedDate),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(),
                            ...order.items.map(
                              (item) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${item.name} (x${item.count})',
                                      ),
                                    ),
                                    Text(
                                      '\$${(item.price * item.count).toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$${order.totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
