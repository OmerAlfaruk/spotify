abstract class SignInState {}

 class SignInInitial extends SignInState {

 }
class SignInSuccess extends SignInState {
 final dynamic signInRequest;

  SignInSuccess({required this.signInRequest});

}
class SignInFailure extends SignInState {

}
