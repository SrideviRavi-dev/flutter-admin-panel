// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'package:admin/data/repositorries/authentication/authentication_repository.dart';
import 'package:admin/features/personalization/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

 Future<List<AddressModel>> fetchUserAddresses(String userId) async {
  try {
    print("Querying addresses for user ID: $userId"); // Debug log

    final result = await _db
        .collection('Users')
        .doc(userId)
        .collection('Addresses')
        .get();

    print("Fetched address docs count: ${result.docs.length}"); // Debug log

    return result.docs
        .map((documentSnapshot) =>
            AddressModel.fromDocumentSnapshot(documentSnapshot))
        .toList();
  } catch (e) {
    print("Error fetching addresses: $e");
    throw 'Something went wrong while fetching Address Information. Try again later';
  }
}


  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update Your address selection.Try again later';
    }
  }

  
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
     final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
     return currentAddress.id;
    } catch (e) {
      throw 'Unable to update Your address selection.Try again later';
    }
  }
}
