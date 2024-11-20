import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/domain/usecases/auth/sign_in_use_case.dart';
import 'package:spotify/presentation/auth/block/sign_in_state.dart';
import 'package:spotify/service_locator/service_locator.dart';



class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signIn(SignInUserRequest signInRequest)async {
   var result =await sl<SignInUseCase>().call(params: signInRequest);
   result.fold((error){
     emit(SignInFailure());
   }, (data){
     emit(SignInSuccess(signInRequest: data));
   });

  }
}
