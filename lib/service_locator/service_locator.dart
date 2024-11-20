import 'package:get_it/get_it.dart';
import 'package:spotify/data/repositoryImpl/auth/auth.dart';
import 'package:spotify/data/repositoryImpl/song/song.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song.dart';
import 'package:spotify/domain/repositories/auth/auth.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify/domain/usecases/auth/logout_usecase.dart';
import 'package:spotify/domain/usecases/auth/sign_in_use_case.dart';
import 'package:spotify/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify/domain/usecases/songs/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/songs/get_new_song_usecase.dart';
import 'package:spotify/domain/usecases/songs/get_playa_list_use_case.dart';
import 'package:spotify/domain/usecases/songs/is_favorite_song.dart';

import '../domain/usecases/songs/get_user_favorite_song.dart';

final sl=GetIt.instance;
Future<void> initializeDependencies()async{
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImp()
  );
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );
  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );
  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );
  sl.registerSingleton<LogoutUseCase>(
      LogoutUseCase()
  );


  // songs

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );
  sl.registerSingleton<SongRepository>(
      SongRepositoryImpl()
  );

  sl.registerSingleton<GetNewsSongUseCase>(
      GetNewsSongUseCase()
  );
  sl.registerSingleton<GetPlayaListUseCase>(
      GetPlayaListUseCase()
  );
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase()
  );
  sl.registerSingleton<IsFavoriteSongUseCase>(
      IsFavoriteSongUseCase()
  );

  sl.registerSingleton<GetUserFavoriteSongUseCase>(
    GetUserFavoriteSongUseCase()
  );
}