import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
<<<<<<< Updated upstream
import 'package:digiday_admin_panel/features/business/data/business_model.dart';
=======
>>>>>>> Stashed changes
import 'package:digiday_admin_panel/features/products/data/product_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  final preferenceRef = SharedPreferenceRef.instance;

  Future<String?> productPicUpload(String imagePath) async {
    String uniqueFileName = "offer_banner_"+Timestamp.now().microsecondsSinceEpoch.toString();
    String? response=await FirebaseService.uploadImageMethod( folder: ApiUrl.offerBannersFolder, fileToUpload: imagePath,uniqueFileName: uniqueFileName);
      return response;
  }

  Future<bool?> addProduct(Map<String,dynamic> data)async{
    try{
      bool? result = await FirebaseService.addDocToCollection(collection: FirebaseKeys.productsCollection, docData: data);
      return result;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }


  Future<bool?> updateProduct(String? offerId,Map<String,dynamic> data)async{
    try{
      bool?  offer = await FirebaseService.updateDocById(data, offerId!, FirebaseKeys.productsCollection);
      return offer;
    }
    on FirebaseException catch (e) {
      rethrow;
    }
  }




  Future<List<Product>?> fetchProducts() async{
    try{
      return FirebaseService.fetchDocs(FirebaseKeys.productsCollection)
          .then((QuerySnapshot? snapshot){
        if (snapshot != null) {
          List<Product> productsList=[];
          for (var element in snapshot.docs) {
            String? productId=element.id;
            var productData=element.data()  as Map<String,dynamic>;
            productData['id']=productId;
            Product obj=Product.fromJson(productData);
            productsList.add(obj);
          }

          if(productsList!=null){
            return productsList;
          }
        }
        else{
          debugPrint("No Products available");
        }
      });
    }
    on FirebaseException catch(e){
      debugPrint(e.message);
    }

  }
}