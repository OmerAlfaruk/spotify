

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/models/auth/cerate_user_request.dart';
import 'package:spotify/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify/presentation/auth/block/signup_state.dart';
import 'package:spotify/service_locator/service_locator.dart';



class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signupUser(CreateUserReq createUser) async {
    emit(SignupInitial()); // Emit loading state before starting the operation.

    var result = await sl<SignupUseCase>().call(params: createUser);

    result.fold(
          (failure) {
        // If the result is a failure, emit the failure state with an error message.
        emit(SignupFailure());
      },
          (user) {
        // If the result is successful, emit success with the returned user data.
        emit(SignupSuccess(createUserReq: user));
      },
    );
  }
}

