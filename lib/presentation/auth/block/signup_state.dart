import 'package:spotify/data/models/auth/cerate_user_request.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupSuccess extends SignupState {
  final dynamic createUserReq;

  SignupSuccess({required this.createUserReq});
}
class SignupFailure extends SignupState {}
