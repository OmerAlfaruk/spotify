import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/songs/get_new_song_usecase.dart';
import 'package:spotify/presentation/home/bloc/news_songs/news_songs_state.dart';
import 'package:spotify/service_locator/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState>{
  NewsSongsCubit():super(NewsSongsLoading());
Future<void> getNewsSong()async{
  var returnedSongs=await sl<GetNewsSongUseCase>().call();

  returnedSongs.fold(
          (l){
            emit(NewsSongsLoadFailure());
          },
          (data){
            emit(NewsSongsLoaded(songs: data));
          }
  );
}
}