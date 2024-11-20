import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/service_locator/service_locator.dart';


class LogoutUseCase extends UseCase<Either,dynamic>{

  @override
  Future<Either> call({params}) {
    return sl<AuthRepository>().logout();
  }

}