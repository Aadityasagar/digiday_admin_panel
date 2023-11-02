import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/account/data/models/user_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class VendorRepository {

  List<UserData> vendorMates=[];


  Future<List<UserData>?> fetchVendorData() async{
    try{
      return FirebaseService.fetchDocsByWhereClause(FirebaseKeys.isVendor, true, FirebaseKeys.usersCollection)
          .then((QuerySnapshot? snapshot)async{
        if (snapshot != null) {
          for (var element in snapshot.docs) {
            var userData=element.data()  as Map<String,dynamic>;
            if (userData != null) {

              UserData _vendorData = UserData(
                firstName: userData['firstName'],
                lastName: userData['lastName'],
                email: userData['email'],
                phone: userData['phone'],
              );
              vendorMates.add(_vendorData);
            }
          }
          return vendorMates;

        }}
      );
    } on FirebaseService catch(e){
      rethrow;
    }

  }




}