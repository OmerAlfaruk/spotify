
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/domain/usecases/songs/add_or_remove_favorite_song.dart';
import 'package:spotify/service_locator/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState>{
  FavoriteButtonCubit():super(FavoriteButtonInitial());
  void favoriteButtonUpdated(String songId)async{
    var result= await sl<AddOrRemoveFavoriteSongUseCase>().call(
      params: songId
    );

    result.fold((l){
      print(l.toString());
    },
            (isFavorite){
      emit(FavoriteButtonUpdated(isFavorite:isFavorite));

            });
  }
}