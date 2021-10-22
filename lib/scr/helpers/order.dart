import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_efinder/scr/models/cart_item.dart';
import 'package:flutter_efinder/scr/models/order.dart';

class OrderServices{
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  void createOrder({String userId, String userName, String id, String description, String status, List<CartItemModel> cart, int totalPrice}) {
   List<Map> convertedCart = [];
   List<String> centerIds = [];

   for(CartItemModel item in cart){
     convertedCart.add(item.toMap());
     centerIds.add(item.centerId);
   }


    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "centerIds": centerIds,
      "cart": convertedCart,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

}