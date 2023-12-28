import 'package:digiday_admin_panel/models/plan_model.dart';

class Subscription {
  String? id;
  DateTime? lastRechargeDate;
  DateTime? nextRechargeDate;
  String? currentPlanId;
  Plan? planDetails;

  Subscription({
    this.id,
    this.lastRechargeDate,
    this.nextRechargeDate,
    this.currentPlanId,
    this.planDetails
  });
}


