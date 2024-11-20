import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator/service_locator.dart';

class IsFavoriteSongUseCase extends UseCase<bool,String>{
  @override
  Future<bool> call({String? params}) async{
    return sl<SongRepository>().isFavoriteSong(params!);
  }
}