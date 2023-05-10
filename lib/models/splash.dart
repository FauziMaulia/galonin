import 'package:flutter/foundation.dart';

class SplashscreenModel extends ChangeNotifier {
  String appName = "Galonin"; // Nama aplikasi
  String tagline = "Solusi beli galon tanpa ribet"; // Tagline aplikasi
  bool _showTagline= false; // Flag untuk menampilkan/menyembunyikan tagline

  bool get showTagline => _showTagline; // Getter untuk nilai flag showTagline

}
