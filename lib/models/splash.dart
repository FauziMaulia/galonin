import 'package:flutter/foundation.dart';

class SplashscreenModel extends ChangeNotifier {
  String appName = "Galonin"; // Nama aplikasi
  String tagline = "Solusi beli galon tanpa ribet"; // Tagline aplikasi
  bool _showTagline= false; // Flag untuk menampilkan/menyembunyikan tagline

  bool get showTagline => _showTagline; // Getter untuk nilai flag showTagline

  // Method untuk mengatur flag showTagline
  void toggleShowTagline() {
    _showTagline = !_showTagline;
    notifyListeners(); // Memberitahu listener bahwa terjadi perubahan pada model
  }
}
