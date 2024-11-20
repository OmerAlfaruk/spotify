import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/data/models/auth/cerate_user_request.dart';
import 'package:spotify/domain/usecases/songs/get_new_song_usecase.dart';
import 'package:spotify/domain/usecases/songs/get_playa_list_use_case.dart';
import 'package:spotify/presentation/home/bloc/playlist/play_list_state.dart';
import 'package:spotify/service_locator/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState>{
  PlayListCubit():super(PlayListLoading());
  Future<void> getPlayList()async{
    var returnedSongs=await sl<GetPlayaListUseCase>().call();

    returnedSongs.fold(
            (l){
          emit(PlayListLoadFailure());
        },
            (data){
          emit(PlayListLoaded(songs: data));
        }
    );
  }
}