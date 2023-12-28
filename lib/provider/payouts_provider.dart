
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/models/payout_model.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/payouts/data/payouts_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class PayoutProvider extends ChangeNotifier{
  final PayoutRepository _payoutRepository= PayoutRepository();

  bool isLoading=false;
  List<Payout> payoutsList=<Payout>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  UserData? selectedCm;

  PayoutProvider(){
    fetchPayouts();
  }


  Future<void> fetchPayouts() async {
    isLoading = true;
    try {
      List<Payout>? response = await _payoutRepository.fetchPayouts();
      if (response != null) {
        payoutsList.clear();
        payoutsList.addAll(response);
      }
      else {
        // Get.to(() => AddBusiness());
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void nextPageData(){
    currentPage=currentPage+1;
    fetchPayouts();
  }



  void updateView(){




  }

}