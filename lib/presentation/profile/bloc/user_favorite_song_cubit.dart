import 'package:bloc/bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/songs/get_user_favorite_song.dart';
import 'package:spotify/presentation/profile/bloc/user_favorite_song_state.dart';
import 'package:spotify/service_locator/service_locator.dart';

class UserFavoriteSongCubit extends Cubit<UserFavoriteSongState> {
  UserFavoriteSongCubit() : super(UserFavoriteSongLoading());
List<SongEntity> favoriteSongs=[];
  Future<void> getUserFavoriteSong()async{
   var result= await sl<GetUserFavoriteSongUseCase>().call();

   result.fold((l){
     emit(UserFavoriteSongLoadFailure());
   }, (songs){
     favoriteSongs=songs;
     emit(UserFavoriteSongLoaded(songs: favoriteSongs));
   });

  }
  Future<void> removeFromFavorite(int index)async{
   favoriteSongs.removeAt(index);
   emit(UserFavoriteSongLoaded(songs: favoriteSongs));

  }

}
