import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/cerate_user_request.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/service_locator/service_locator.dart';

class SignupUseCase extends UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call({CreateUserReq? params}) {
  return sl<AuthRepository>().signup(params!);
  }


}