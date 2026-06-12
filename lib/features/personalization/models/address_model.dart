import 'package:admin/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => JFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      address: '',
      city: '',
      state: '',
      postalCode: '',
      country: '',
      );

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': DateTime.now(),
      'selectedAddress': selectedAddress,
    };
  }

factory AddressModel.fromMap(Map<String, dynamic> data) {
  return AddressModel(
    id: data['id'] ?? '',
    name: data['name'] ?? '',
    phoneNumber: data['phoneNumber'] ?? '',
    address: data['address'] ?? '',
    city: data['city'] ?? '',
    state: data['state'] ?? '',
    postalCode: data['postalCode'] ?? '',
    country: data['country'] ?? '',
    selectedAddress: data['selectedAddress'] ?? false,
    dateTime: (data['dateTime'] != null) ? (data['dateTime'] as Timestamp).toDate() : null,
  );
}

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>? ?? {}; 

  return AddressModel(
    id: snapshot.id,
    name: data['name'] ?? '',
    phoneNumber: data['phoneNumber'] ?? '',
    address: data['address'] ?? '',
    city: data['city'] ?? '',
    state: data['state'] ?? '',
    postalCode: data['postalCode'] ?? '',
    country: data['country'] ?? '',
    selectedAddress: data['selectedAddress'] ?? false,
    dateTime: (data['dateTime'] != null) ? (data['dateTime'] as Timestamp).toDate() : null,
  );
}

 @override
  String toString() {
    return '$address, $city, $state$postalCode, $country';
  }

}




