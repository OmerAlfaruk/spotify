import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/sign_in_user_request.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator/service_locator.dart';

class GetNewsSongUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
    return sl<SongRepository>().getNewsSongs();
  }
  }



