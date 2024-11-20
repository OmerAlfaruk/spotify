import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator/service_locator.dart';

class GetUserFavoriteSongUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
    return sl<SongRepository>().getUserFavoriteSong();
  }
}
