import 'package:flutter/material.dart';

class EmptyOrdersPage extends StatelessWidget {
  const EmptyOrdersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada orderan nih!',
              style: textTheme.headline5!.copyWith(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Yuk Check Out produk Di keranjang Mu dan selesaikan pembayaran',
              style: textTheme.subtitle1!.copyWith(
                color: Colors.grey[600],
                fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context,'/cart');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),                
                textStyle: textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Check Out Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}