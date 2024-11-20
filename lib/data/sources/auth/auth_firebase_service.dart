import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/data/models/auth/cerate_user_request.dart';
import 'package:spotify/data/models/auth/user.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SignInUserRequest signInUserRequest);
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> getUser();
  Future<Either> logout();
}

class AuthFirebaseServiceImp extends AuthFirebaseService {
  @override
  Future<Either> signin(SignInUserRequest signInUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserRequest.email, password: signInUserRequest.password);
      return const Right("Sign in successful");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'Invalid-email') {
        message = 'User not found for that email';
      } else if (e.code == 'Invalid-credential') {
        message = 'Wrong password provided';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      // Use the user's UID as the document ID for better structure
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data.user?.uid)
          .set({
        'fullName': createUserReq.fullname ??
            "Unnamed User", // Use a default if name is null
        'email': data.user?.email ?? "",
        'createdAt': FieldValue.serverTimestamp(),
      });

      return Right(data.user);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      } else {
        message = 'An error occurred: ${e.message}';
      }
      return Left(message);
    } catch (e) {
      // Catch unexpected errors
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // Check if a user is currently authenticated
      if (firebaseAuth.currentUser == null) {
        return Left('No user is currently authenticated.');
      }

      // Fetch user document from Firestore
      var userDoc = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      // Check if user data exists
      if (!userDoc.exists || userDoc.data() == null) {
        return Left('User data not found in Firestore.');
      }

      // Parse the user data
      UserModel userModel = UserModel.fromJson(userDoc.data()!);

      // Set default profile image if photoURL is null
      userModel.imageUrl = firebaseAuth.currentUser?.photoURL ?? AppURls.defaultProfile;

      // Convert to UserEntity
      UserEntity userEntity = userModel.toEntity();

      print(userEntity);
      return Right(userEntity);
    } catch (e) {
      print('Error fetching user: $e');
      return Left(e.toString());
    }
  }
  @override
  Future<Either> logout()async{
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }


}
