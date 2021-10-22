import 'package:flutter/material.dart';
import '../helpers/center.dart';
import '../models/center.dart';

class CenterProvider with ChangeNotifier{
  CenterServices _centerServices = CenterServices();
  List<CenterModel> centers = [];
  List<CenterModel> searchedCenters = [];

  CenterModel center;

  CenterProvider.initialize(){
    loadCenters();
  }

  loadCenters()async{
    centers = await _centerServices.getCenters();
    notifyListeners();
  }

  Future loadSingleCenter({String centerId}) async{
    center = await _centerServices.getCenterById(centerId: centerId);
    notifyListeners();
  }

  Future search({String name})async{
    searchedCenters = await _centerServices.searchCenter(centerName: name);
    print("RESTOS ARE: ${searchedCenters.length}");
    notifyListeners();
  }
}