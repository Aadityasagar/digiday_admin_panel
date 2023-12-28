import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/subscription.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/subscribers/data/subscribers_repository.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../utils/services/network/api_exception.dart';

class SubscribersProvider extends ChangeNotifier{
final SubscribersRepository _subscribersRepository=SubscribersRepository();
bool isLoading=false;
List<Subscription> activeVendors=<Subscription>[];

final List<Tab> pageTabs = <Tab>[
  const Tab(text: 'Active'),
  const Tab(text: 'In-Active'),
];

SubscribersProvider(){

}




}