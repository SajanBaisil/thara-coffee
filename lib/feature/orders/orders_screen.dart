import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Here would be a list of orders'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to OrderDetailsScreen
              },
              child: Text('View Order Details'),
            ),
          ],
        ),
      ),
    );
  }
}
