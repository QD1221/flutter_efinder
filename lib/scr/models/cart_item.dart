
class CartItemModel {
  static const ID = "id";
  static const USERNAME = "userName";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const CENTER_ID = "centerId";



  String _id;
  String _userName;
  String _name;
  String _image;
  String _productId;
  String _centerId;
  int _totalCenterSale;
  int _price;



  //  getters
  String get id => _id;

  String get userName => _userName;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get centerId => _centerId;

  int get price => _price;

  int get totalCenterSale => _totalCenterSale;



  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _userName = data[USERNAME];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _centerId = data[CENTER_ID];
  }

  Map toMap() => {
    ID: _id,
    USERNAME: _userName,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    PRICE: _price,
    CENTER_ID: _centerId,

  };
}
