import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_efinder/scr/models/cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";

  String _name;
  String _email;
  String _id;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;

//  public variable
  List<CartItemModel> cart;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    cart = _convertCartItems(snapshot.data[CART]) ?? [];
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
