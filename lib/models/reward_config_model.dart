import 'package:digiday_admin_panel/models/plan_model.dart';

class RewardConfig {
  String? id;
  String? planId;
  String? first;
  String? second;
  String? third;
  String? fourth;
  String? fifth;
  Plan? planDetails;

  RewardConfig({
    this.id,
    this.planId,
    this.first,
    this.second,
    this.third,
    this.fourth,
    this.fifth
});
}