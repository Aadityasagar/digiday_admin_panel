import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/models/orders_model.dart';
import 'package:digiday_admin_panel/models/plan_model.dart';
import 'package:digiday_admin_panel/models/subscription.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/common/common_functions.dart';
import 'package:digiday_admin_panel/screens/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/screens/subscribers/data/subscribers_repository.dart';
import 'package:digiday_admin_panel/screens/vendor/data/vendor_repository.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorProvider extends ChangeNotifier {
  final VendorRepository _vendorRepository = VendorRepository();
  final SubscribersRepository _subscribersRepository = SubscribersRepository();

  bool isLoading = false;
  List<UserData> activeVendorMates = <UserData>[];
  List<UserData> inactiveVendorMates = <UserData>[];
  List<UserData> itemsToDisplay = <UserData>[];

  List<Product> vendorsProducts = <Product>[];

  List<OrderData> vendorOrders = <OrderData>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage = 1;
  int itemsPerPageLimit = 100;
  int totalItems = 10;

  final List<Tab> pageTabs = <Tab>[
    const Tab(text: 'Active'),
    const Tab(text: 'In-Active'),
  ];

  UserData? selectedVendor;

  RxInt currentVendorWalletBalance=0.obs;

  VendorProvider() {
    fetchActiveVendorsData();
    fetchInactiveVendorsData();
  }

  Future<void> fetchInactiveVendorsData() async {
    isLoading = true;
    try {
      QuerySnapshot? response =
          await _vendorRepository.fetchInactiveVendorsData(
              limitPerPage: itemsPerPageLimit, lastDocument: lastDocument);
      if (response != null) {
        processInactiveVendorData(response);
      } else {}
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchActiveVendorsData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _vendorRepository.fetchActiveVendorsData(
          limitPerPage: itemsPerPageLimit, lastDocument: lastDocument);
      if (response != null) {
        processActiveVendorData(response);
      } else {}
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  void nextPageData() {
    currentPage = currentPage + 1;
    fetchActiveVendorsData();
    fetchInactiveVendorsData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL =
        await FirebaseStorage.instance.ref().child(img).getDownloadURL();

    return downloadURL;
  }

  Future<Plan?> fetchPlanDetails(String planId) async {
    DocumentSnapshot? documentSnapshot =
        await _subscribersRepository.fetchVendorPlanDetails(planId: planId);
    if (documentSnapshot != null) {
      Map<String, dynamic>? subData = documentSnapshot.data() as Map<String, dynamic>?;
      if (subData != null) {
        Plan result = Plan(
          id: documentSnapshot.id,
          rate: subData['rate'],
          name: subData['name'],
          validityInDays: subData['validityInDays']
        );

        return result;
      }
    }
  }

  Future<Subscription?> fetchSubscriptionData(String userId) async {
    DocumentSnapshot? documentSnapshot = await _subscribersRepository.fetchVendorSubscriptionData(userId: userId);
    if (documentSnapshot != null) {
      Map<String, dynamic>? subData = documentSnapshot.data() as Map<String, dynamic>?;

      if (subData != null) {
        Subscription sub = Subscription(
          id: documentSnapshot.id,
          lastRechargeDate: DateTime.fromMillisecondsSinceEpoch(
              (subData['lastRechargeDate'])),
          nextRechargeDate: DateTime.fromMillisecondsSinceEpoch(
              (subData['nextRechargeDate'])),
          currentPlanId: subData['currentPlan'],
        );

        if (subData['currentPlan'] != null) {
          Plan? planData = await fetchPlanDetails(subData['currentPlan']);
          sub.planDetails=planData;
        }

        return sub;
      }
    }
  }

  void processActiveVendorData(QuerySnapshot snapshot) async {
    try {
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var userData = element.data() as Map<String, dynamic>;
          if (userData.isNotEmpty) {
            UserData vendorData = UserData(
                userId: element.id,
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
                userSubscriptionStatus: userData['userSubscriptionStatus']);

            if (userData['photo'] != null) {
              vendorData.photo = await fetchImageUrl(
                  "${ApiUrl.vendorProfilePicsDirectory}/${userData['photo']}");
            }

            if (userData['userSubscriptionStatus'] != null) {
              Subscription? vendorsSubscription =
                  await fetchSubscriptionData(vendorData.userId!);
              vendorData.subscription = vendorsSubscription;
            }

            activeVendorMates.add(vendorData);
          }
        }

        lastDocument = snapshot.docs.last;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void processInactiveVendorData(QuerySnapshot snapshot) async {
    try {
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var userData = element.data() as Map<String, dynamic>;
          if (userData != null) {
            UserData inActiveVendorData = UserData(
                userId: element.id,
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
                userSubscriptionStatus: userData['userSubscriptionStatus']);

            if (userData?['photo'] != null) {
              inActiveVendorData.photo = await fetchImageUrl(
                  "${ApiUrl.vendorProfilePicsDirectory}/${userData?['photo']}");
            }

            inactiveVendorMates.add(inActiveVendorData);
          }
        }

        lastDocument = snapshot.docs.last;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }


  Future<List<Product>?> fetchProductsByVendorId(String vendorId) async{
    vendorsProducts.clear();
    try{
      return FirebaseService.fetchDocsByWhereClause( filterKey : FirebaseKeys.ownerId, filterValue : vendorId, collection: FirebaseKeys.businessesCollection)
          .then((QuerySnapshot? snapshot)async{
        if (snapshot != null) {
          for (var element in snapshot.docs) {
            String? businessId=element.id;

            return FirebaseService.fetchDocsByWhereClause(filterKey: FirebaseKeys.businessId, filterValue: businessId, collection: FirebaseKeys.productsCollection)
                .then((QuerySnapshot? snapshot){
              if (snapshot!=null) {
                for (var element in snapshot.docs) {
                  var product=element.data()  as Map<String,dynamic>;
                  Product obj=Product.fromJson(product);
                  vendorsProducts.add(obj); }
              }
            });
          }

          if(vendorsProducts!=null){
            return vendorsProducts;
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

  Future<List<OrderData>?> fetchOrdersByVendorId(String vendorId) async{
    vendorOrders.clear();
    try{
      return FirebaseService.fetchDocsByWhereClause( filterKey : FirebaseKeys.ownerId, filterValue : vendorId, collection: FirebaseKeys.businessesCollection)
          .then((QuerySnapshot? snapshot)async{
        if (snapshot != null) {
          for (var element in snapshot.docs) {
            String? businessId=element.id;

            await FirebaseService.fetchDocsByWhereClause(filterKey: FirebaseKeys.businessId, filterValue: businessId, collection: FirebaseKeys.orders)
                .then((QuerySnapshot? snapshot){
              if (snapshot!=null) {
                for (var element in snapshot.docs) {
                  var orders=element.data()  as Map<String,dynamic>;
                  OrderData obj=OrderData.fromJson(orders);
                  vendorOrders.add(obj); }
              }
            });
          }

          if(vendorOrders!=null){
            return vendorOrders;
          }
        }
        else{
          debugPrint("No Orders available");
        }
      });
    }
    on FirebaseException catch(e){
      debugPrint(e.message);
    }

  }

  Future<void> fetchWalletBalanceByVendorId(String vendorId) async {
    currentVendorWalletBalance.value=0;
    try{
      String? walletBalance =await _vendorRepository.fetchVendorWalletBalance(vendorId);
      if(walletBalance!=null){
        currentVendorWalletBalance.value= int.parse(walletBalance);
      }
      else{
        print("Users wallet data not available");

      }
    }
    on ApiException catch(e){
      if(e.status==ApiExceptionCode.sessionExpire){
        CommonFunctions.showSnackBar(title: "Alert", message: "Session Expired", type: PopupType.error);
        // Get.offAll(()=> LogInScreen());
      }
    }

  }

}
