import 'package:flutter/material.dart';
import '../../models/api/cart_services.dart';
import '../../models/cart.dart';

class CartViewModel with ChangeNotifier {
  List<Cart>? _cartItems ;
  bool _isLoading = false;
  String _errorMessage = '';

  List<Cart> get cartItems => _cartItems??[];
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  CartService cartService = CartService();
  int x=1;

   fetchCartItems() async {
    try {
      _isLoading = true;
      _cartItems = await cartService.getCartList();
      print('${_cartItems?.length} $x');
    } catch (e) {
      _errorMessage = 'Failed to load cart items';
    } finally {
      
      print('${_cartItems?.length} $x');
      x+=1;
      _isLoading = false;
      notifyListeners();
    }
  }

  void addItemToCart(Cart cartItem) async {
    try {
      await cartService.addCart(cartItem);
      _cartItems!.add(cartItem);
    } catch (e) {
      _errorMessage = 'Failed to add item to cart';
    } finally {
      notifyListeners();
    }
  }

  void removeItemFromCart(int id) async {
    try {
      await cartService.deleteCart(id);
    } catch (e) {
      _errorMessage = 'Failed to remove item from cart';
    } finally {
      notifyListeners();
    }
  }
  Future<void> updateCart(Cart cart) async {
    try {
      await cartService.updateCart(cart);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
