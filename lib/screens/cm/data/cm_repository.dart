import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/account/data/models/user_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class CmRepository {

  List<UserData> cmTeamMates=[];


  Future<List<UserData>?> fetchCmTeamData() async{
    try{
      return FirebaseService.fetchDocsByWhereClause(FirebaseKeys.isCm, true, FirebaseKeys.usersCollection)
          .then((QuerySnapshot? snapshot)async{
        if (snapshot != null) {
          for (var element in snapshot.docs) {
            var userData=element.data()  as Map<String,dynamic>;
            if (userData != null) {

              UserData _cmTeamData = UserData(
                firstName: userData['firstName'],
                lastName: userData['lastName'],
                email: userData['email'],
                phone: userData['phone'],
              );
              cmTeamMates.add(_cmTeamData);
            }
          }
          return cmTeamMates;

        }}
      );
    } on FirebaseService catch(e){
      rethrow;
    }

  }




}