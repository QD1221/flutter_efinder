import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const CREATED_AT = "createdAt";
  static const CENTER_ID = "centerId";


  String _id;
  String _centerId;
  String _description;
  String _userId;
  int _createdAt;

//  getters
  String get id => _id;
  String get centerId => _centerId;
  String get description => _description;
  String get userId => _userId;
  int get createdAt => _createdAt;

  // public variable
  List cart;


  OrderModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION];
    _userId = snapshot.data[USER_ID];
    _createdAt = snapshot.data[CREATED_AT];
    _centerId = snapshot.data[CENTER_ID];
    cart = snapshot.data[CART];
  }









}