import 'package:flutter/material.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Pesanan Berhasil Dibuat!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Silahkan Bayar Tagihan ke Pilihan Berikut:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '1. Dana : 089xxxxxxx',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '2. Gopay : 67900xxxxx',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '3. Shopee Pay : 2234555xxxxx',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Atau Transfer Bank',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Konfirmasi Pembayaran lewat WA ke Nomor:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '08123456789',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomAppBar(
        child: 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                 Navigator.pushNamed(context,'/home');
                },
                child: const Text('Back to Home'),
              ),
            ),
      ),
    );
  }
}
