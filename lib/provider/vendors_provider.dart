import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/plan_model.dart';
import 'package:digiday_admin_panel/models/subscription.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/subscribers/data/subscribers_repository.dart';
import 'package:digiday_admin_panel/screens/vendor/data/vendor_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class VendorProvider extends ChangeNotifier {
  final VendorRepository _vendorRepository = VendorRepository();
  final SubscribersRepository _subscribersRepository = SubscribersRepository();

  bool isLoading = false;
  List<UserData> activeVendorMates = <UserData>[];
  List<UserData> inactiveVendorMates = <UserData>[];
  List<UserData> itemsToDisplay = <UserData>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage = 1;
  int itemsPerPageLimit = 100;
  int totalItems = 10;

  final List<Tab> pageTabs = <Tab>[
    const Tab(text: 'Active'),
    const Tab(text: 'In-Active'),
  ];

  UserData? selectedVendor;

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
}
