import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/data/models/auth/cerate_user_request.dart';

abstract class AuthRepository{
  Future<Either> signup(CreateUserReq createUserRequest);
  Future<Either>  signin(SignInUserRequest signInUserRequest);
  Future<Either> getUser();
  Future<Either> logout();
}