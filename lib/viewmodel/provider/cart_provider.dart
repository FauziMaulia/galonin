import 'package:flutter/material.dart';
import '../../models/api/cart_services.dart';
import '../../models/cart.dart';

class CartViewModel with ChangeNotifier {
  List<Cart>? _cartItems ;
  late Cart? _cart;
  bool _isLoading = false;
  String _errorMessage = '';
  List<int> _cartProductId = [];
  bool _isInCart = false;
  List<bool> _IsCart = [];

  Cart? get cart => _cart;
  List<Cart> get cartItems => _cartItems??[];
  List<int> get cartProductId => _cartProductId;
  bool get isLoading => _isLoading;
  bool get isInCart => _isInCart;
  List<bool> get IsCart => _IsCart;
  String get errorMessage => _errorMessage;
  CartService cartService = CartService();



  Future<void> fetchCartItems() async {
    try {
      _isLoading = true;
      _cartItems = await cartService.getCartList();
      if(cartProductId!=[]){
        cartProductId.clear();
        _cartItems!.forEach((item) {
            cartProductId.add(item.productId);
      });
      }else{
        _cartItems!.forEach((item) {
            cartProductId.add(item.productId);
      });
      }
    } catch (e) {
      _errorMessage = 'Failed to load cart items';
    } finally {
      
      _isLoading = false;
      notifyListeners();
    }
  }

Future<void> getCartByProductId(int productId) async {
    try {
      _cart = await cartService.getCartByProductId(productId);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
  
  Future<void> deleteCart(int cartId,int productId) async {
    try {
      await cartService.deleteCart(cartId);
     _cartProductId.remove(productId);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

 Future<void> InCart(int id) async {
  try{
    _isInCart = cartProductId.contains(id);
  }catch(e){
    throw e;
  }

}



 Future<void> addItemToCart(Cart cartItem) async {
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

  void removeAllItemFromCart() async {
    try {
      await cartService.deleteAllCart();
      
    } catch (e) {
      _errorMessage = 'Failed to remove item from cart';
    } finally {
      notifyListeners();
    }
  }
  
  Future<void> incrementCart(int productId) async {
    try {
      await cartService.incrementCart(productId);
      await fetchCartItems();
    } catch (e) {
      print('Error incrementing cart: $e');
    }
  }

  Future<void> decrementCart(int productId) async {
    try {
      await cartService.decrementCart(productId);
      await fetchCartItems();
    } catch (e) {
      print('Error decrementing cart: $e');
    }
  }
}
