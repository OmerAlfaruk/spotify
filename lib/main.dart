import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/core/configs/theme/app_theme.dart';
import 'package:spotify/firebase_options.dart';
import 'package:spotify/presentation/auth/block/sign_in_cubit.dart';
import 'package:spotify/presentation/auth/block/signup_cubit.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify/presentation/home/bloc/news_songs/news_songs_cubit.dart';
import 'package:spotify/presentation/home/bloc/playlist/playlist_cubit.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/presentation/song_player/bloc/song_player/song_player_cubit.dart';
import 'package:spotify/presentation/splash/pages/splash.dart';
import 'package:spotify/service_locator/service_locator.dart';

import 'common/bloc/favorite_button/favorite_button_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => NewsSongsCubit()..getNewsSong()),
        BlocProvider(create: (_) => PlayListCubit()..getPlayList()),
        BlocProvider(create: (_) => SignupCubit()),
        BlocProvider(create: (_) => SignInCubit()),

      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            debugShowCheckedModeBanner: false,
            home: const SplashPage()),
      ),
    );
  }
}
