// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:async';

import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController{
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;

   @override
void onInit() {
  super.onInit();
  
_connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updatedConnectionStatus);

}
  
    Future<void> _updatedConnectionStatus(List<ConnectivityResult> result) async {
      _connectionStatus.value = result;
      if(result.contains(ConnectivityResult.none)){
        JLoaders.customToast(message: 'No Internet Connection');
      }
    }

  
  Future<bool> isConnected() async{
  try{
    final result = await _connectivity.checkConnectivity();
    if(result.any((element)=> element == ConnectivityResult.none)){
      return false;
    }else{
      return true;
    }
  }on PlatformException catch(_) {
    return false;
  }
 }

 @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
}

}