import 'package:admin/routes/routes.dart';
import 'package:admin/utils/exception/firebase_auth_exception.dart';
import 'package:admin/utils/exception/firebase_exception.dart';
import 'package:admin/utils/exception/format_exception.dart';
import 'package:admin/utils/exception/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User data
  User? get authUser => _auth.currentUser;

  // Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady(){
   _auth.setPersistence(Persistence.LOCAL);
  }

   void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null){
      Get.offAllNamed(JRoutes.dashboard);
    //  Get.to(()=> const DashboardScreen());
    }else{

      Get.offAllNamed(JRoutes.login);
    }
   }
   

  // Login
   Future<UserCredential>loginwithEmailAndPassword(String email, String password) async{
    try{
     return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
   }
   
  //Register 
   Future<UserCredential>registerwithEmailAndPassword(String email, String password) async{
   try{
     return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
   }


  // Register User by admin

  // Email Verification

  // Forgot password

  // Re Authentication User

  // Logout User
 Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(JRoutes.login);
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  // Delete User
}
