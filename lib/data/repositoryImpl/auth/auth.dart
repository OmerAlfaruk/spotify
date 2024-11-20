import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/data/models/auth/cerate_user_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/service_locator/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{


  @override
  Future<Either>  signin(SignInUserRequest signInUserRequest) async {
    return await sl<AuthFirebaseService>().signin(signInUserRequest);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq)async {
return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser()async {
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either> logout() {
   return sl<AuthFirebaseService>().logout();
  }

}