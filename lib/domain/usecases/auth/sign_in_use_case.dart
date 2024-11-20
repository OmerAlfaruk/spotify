import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/service_locator/service_locator.dart';

class SignInUseCase extends UseCase<Either,SignInUserRequest>{
  @override
  Future<Either> call({SignInUserRequest? params}) {
    return sl<AuthRepository>().signin(params!);
  }


}