import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/plan_model.dart';
import 'package:digiday_admin_panel/models/subscription.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/cm/data/cm_repository.dart';
import 'package:digiday_admin_panel/screens/subscribers/data/subscribers_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CmProvider extends ChangeNotifier {
  final CmRepository _myCmTeamRepository = CmRepository();
  final SubscribersRepository _subscribersRepository = SubscribersRepository();

  bool isLoading = false;
  List<UserData> activeCmTeamMates = <UserData>[];
  List<UserData> inactiveCmTeamMates = <UserData>[];
  List<UserData> itemsToDisplay = <UserData>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage = 1;
  int itemsPerPageLimit = 100;
  int totalItems = 10;

  final List<Tab> pageTabs = <Tab>[
    const Tab(text: 'Active'),
    const Tab(text: 'In-Active'),
  ];

  UserData? selectedCm;

  CmProvider() {
    fetchActiveCmTeamData();
    fetchInactiveCmTeamData();
  }

  Future<void> fetchActiveCmTeamData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _myCmTeamRepository.fetchActiveCmTeamData(
          limitPerPage: itemsPerPageLimit, lastDocument: lastDocument);
      if (response != null) {
        processActiveTeamData(response);
      } else {}
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchInactiveCmTeamData() async {
    isLoading = true;
    try {
      QuerySnapshot? response =
          await _myCmTeamRepository.fetchInactiveCmTeamData(
              limitPerPage: itemsPerPageLimit, lastDocument: lastDocument);
      if (response != null) {
        processInactiveTeamData(response);
      } else {}
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  void nextPageData() {
    currentPage = currentPage + 1;
    fetchActiveCmTeamData();
    fetchInactiveCmTeamData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL =
        await FirebaseStorage.instance.ref().child(img).getDownloadURL();

    return downloadURL;
  }

  Future<Plan?> fetchPlanDetails(String planId) async {
    DocumentSnapshot? documentSnapshot =
        await _subscribersRepository.fetchCmPlanDetails(planId: planId);
    if (documentSnapshot != null) {
      Map<String, dynamic>? subData =
          documentSnapshot.data() as Map<String, dynamic>?;
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
    return null;
  }

  Future<Subscription?> fetchSubscriptionData(String userId) async {
    DocumentSnapshot? documentSnapshot =
        await _subscribersRepository.fetchCmSubscriptionData(userId: userId);
    if (documentSnapshot != null) {
      Map<String, dynamic>? subData =
          documentSnapshot.data() as Map<String, dynamic>?;
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
    return null;
  }

  void processInactiveTeamData(QuerySnapshot snapshot) async {
    try {
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var userData = element.data() as Map<String, dynamic>;
          if (userData.isNotEmpty) {
            UserData cmTeamData = UserData(
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
              cmTeamData.photo = await fetchImageUrl(
                  "${ApiUrl.teamProfilePicsFolder}/${userData['photo']}");
            }

            inactiveCmTeamMates.add(cmTeamData);
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

  void processActiveTeamData(QuerySnapshot snapshot) async {
    try {
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var userData = element.data() as Map<String, dynamic>;
          if (userData.isNotEmpty) {
            UserData cmTeamData = UserData(
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
              cmTeamData.photo = await fetchImageUrl(
                  "${ApiUrl.teamProfilePicsFolder}/${userData['photo']}");
            }

            if (userData['userSubscriptionStatus'] != null) {
              Subscription? cmSubscription =
              await fetchSubscriptionData(cmTeamData.userId!);
              cmTeamData.subscription = cmSubscription;
            }

            activeCmTeamMates.add(cmTeamData);
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

  void updateView() {}
}
