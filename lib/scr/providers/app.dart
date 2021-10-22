import 'package:flutter/material.dart';

enum SearchBy{PRODUCTS, CENTERS}

class AppProvider with ChangeNotifier{
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  String filterBy = "Khóa học";
  int totalPrice = 0;
  int priceSum = 0;
  int quantitySum = 0;

  void changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}){
    search = newSearchBy;
    if(newSearchBy == SearchBy.PRODUCTS){
      filterBy = "Khóa học";
    }else{
      filterBy = "Trung tâm";
    }
    notifyListeners();
  }

  addPrice({int newPrice}){
    priceSum += newPrice;
    notifyListeners();
  }

  addQuantity({int newQuantity}){
    quantitySum += newQuantity;
    notifyListeners();
  }

  getTotalPrice(){


    totalPrice = priceSum * quantitySum;
    print("THE TOTAL AMOUNT IS: $totalPrice");


    notifyListeners();
  }

}