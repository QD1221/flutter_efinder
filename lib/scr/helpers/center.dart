import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/center.dart';

class CenterServices {
  String collection = "centers";
  Firestore _firestore = Firestore.instance;

  Future<List<CenterModel>> getCenters() async =>
     await _firestore.collection(collection).getDocuments().then((result) {
        List<CenterModel> centers = [];
        for (DocumentSnapshot center in result.documents) {
          centers.add(CenterModel.fromSnapshot(center));
        }
        return centers;
      });

  Future<CenterModel> getCenterById({String centerId}) async =>
      await _firestore
          .collection(collection)
          .document(centerId)
          .get()
          .then((doc) {
        return CenterModel.fromSnapshot(doc);
      });

  Future<List<CenterModel>> searchCenter({String centerName}) async{
    // code to convert the first character to uppercase
    String searchKey =
        centerName[0].toUpperCase() + centerName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
          List<CenterModel> centers = [];
          for (DocumentSnapshot product in result.documents) {
            centers.add(CenterModel.fromSnapshot(product));
          }
          return centers;
        });
  }
}
