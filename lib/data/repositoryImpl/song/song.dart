import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song/song.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator/service_locator.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getNewsSongs() async{
   return await sl<SongFirebaseService>().getNewsSong();
  }

  @override
  Future<Either> getPlayList() async{
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) {
    return sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) {
 return sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSong() {
    return sl<SongFirebaseService>().getUserFavoriteSong();
  }
}