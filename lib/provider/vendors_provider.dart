import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/vendor/data/vendor_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class VendorProvider extends ChangeNotifier{
  final VendorRepository _vendorRepository=VendorRepository();

  bool isLoading=false;
  List<UserData> vendorMates=<UserData>[];
  List<UserData> itemsToDisplay=<UserData>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  VendorProvider(){
    fetchVendorsData();
  }


  Future<void> fetchVendorsData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _vendorRepository.fetchVendorsData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );
      if (response!= null) {
        processVendorData(response);
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
    fetchVendorsData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }

  void processVendorData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var userData = element.data() as Map<String, dynamic>;
          if (userData != null) {


            UserData vendorData = UserData(
              firstName: userData['firstName'],
              lastName: userData['lastName'],
              email: userData['email'],
              phone: userData['phone'],
            );

            if(userData?['photo']!=null){
              vendorData.photo = await fetchImageUrl("${ApiUrl.vendorProfilePicsDirectory}/${userData?['photo']}");
            }

            vendorMates.add(vendorData);
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





}