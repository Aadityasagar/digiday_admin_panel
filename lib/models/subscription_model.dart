class SubscriptionData {
  String? vendorId;
  String? status;
  String? currentPlanId;
  String? currentPlanName;
  String? currentPlanRate;
  String? currentPlanValidity;
  DateTime? lastRechargeDate;
  DateTime? nextRechargeDate;


  SubscriptionData({
    this.vendorId,
    this.status,
    this.currentPlanId,
    this.currentPlanName,
    this.currentPlanRate,
    this.currentPlanValidity,
    this.lastRechargeDate,
    this.nextRechargeDate
  });

}