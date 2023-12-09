import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/features/subscription_repository.dart';
import 'package:digiday_admin_panel/models/subscription_model.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/vendor/data/vendor_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class VendorProvider extends ChangeNotifier{
  final VendorRepository _vendorRepository=VendorRepository();
  final SubscriptionRepository _subscriptionRepository=SubscriptionRepository();

  bool isLoading=false;
  List<UserData> vendorMates=<UserData>[];
  List<UserData> itemsToDisplay=<UserData>[];
  List<SubscriptionData> subscribers=<SubscriptionData>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  UserData? selectedVendor;

  VendorProvider(){
    fetchVendorsData();
    fetchSubscriptionStatus();
  }

  Future<void> fetchSubscriptionStatus()async{
    isLoading = true;
    try {
      QuerySnapshot? status = await _subscriptionRepository.fetchSubscriptionData();
      if (status!= null) {
        processSubscriptionData(status);
      }
      else {
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
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

  void processSubscriptionData(QuerySnapshot snapshot)async{
    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var subStatus = element.data() as Map<String, dynamic>;
          if (subStatus != null) {

            SubscriptionData subscriptionData =SubscriptionData(
              status: subStatus['status']
            );

            subscribers.add(subscriptionData);
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
              referredBy: userData['referredBy'],
              referralCode: userData['referralCode'],
              address: userData['address'],
              city: userData['city'],
              pinCode: userData['pinCode'],
              state: userData['state'],
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