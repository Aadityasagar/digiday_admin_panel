import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/cm/data/cm_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CmProvider extends ChangeNotifier{
  final CmRepository _myCmTeamRepository= CmRepository();

  bool isLoading=false;
  List<UserData> cmTeamMates=<UserData>[];
  List<UserData> itemsToDisplay=<UserData>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=2;
  int totalItems=10;

  CmProvider(){
    fetchCmTeamData();
  }


  Future<void> fetchCmTeamData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _myCmTeamRepository.fetchCmTeamData(
        limitPerPage: itemsPerPageLimit,
        lastDocument: lastDocument
      );
      if (response!= null) {
        processTeamData(response);
      }
      else {
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  void nextPageData(){
    currentPage=currentPage+1;
    fetchCmTeamData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }

  void processTeamData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var userData = element.data() as Map<String, dynamic>;
          if (userData != null) {


            UserData _cmTeamData = UserData(
              firstName: userData['firstName'],
              lastName: userData['lastName'],
              email: userData['email'],
              phone: userData['phone'],
            );

            if(userData?['photo']!=null){
              _cmTeamData.photo = await fetchImageUrl("${ApiUrl.teamProfilePicsFolder}/${userData?['photo']}");
            }

            cmTeamMates.add(_cmTeamData);
          }
        }

        lastDocument=snapshot.docs.last;
      }
    }on Exception catch(e){
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }

  }

  void updateView(){




  }

}