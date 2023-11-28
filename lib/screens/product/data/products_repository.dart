import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class ProductsRepository{
  List<Product> productsList = [];

  Future<QuerySnapshot?> fetchProductsData() async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocs(FirebaseKeys.productsCollection);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }
}