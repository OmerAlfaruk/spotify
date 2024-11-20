import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widget/app_bar/common_app_bar.dart';
import 'package:spotify/common/widget/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/song_player/bloc/song_player/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player/song_player_state.dart';

import '../../../common/bloc/favorite_button/favorite_button_cubit.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 14),
        ),
        action: IconButton(
            onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
              '${AppURls.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppURls.mediaAlt}'),
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                _songCover(context),
                const SizedBox(
                  height: 20,
                ),
                _songDetail(),
                SizedBox(height: 30,),
                _songPlayer()
              ],
            )),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                '${AppURls.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppURls.mediaAlt}',
              ))),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(songEntity.artist,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
        BlocProvider(
          create: (_) => FavoriteButtonCubit(),
          child: FavoriteButton(songEntity: songEntity),
        ),
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      if (state is SongPlayerLoading) {
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
      if (state is SongPlayerLoaded) {
        return Column(
          children: [
            Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {}),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(context
                    .read<SongPlayerCubit>()
                    .songPosition
                    )),
                Text(formatDuration(context
                    .read<SongPlayerCubit>()
                    .songDuration
                    )),
                
              ],
            ),
            GestureDetector(
              onTap: (){context.read<SongPlayerCubit>().playOrPauseSong();},
              child: Container(
                height: 60,
                width: 60,
                decoration:  const BoxDecoration(shape: BoxShape.circle,
                    color: AppColors.primary,),
                child: Icon(context.read<SongPlayerCubit>().audioPlayer.playing?Icons.pause:Icons.play_arrow,color:context.isDarkMode? const Color(0xff959595):const Color(0xff555555),),
              ),
            ),
          ],
        );
      }
      return Container();
    });
  }
  String formatDuration(Duration duration){
    final minutes=duration.inMinutes.remainder(60);
    final seconds=duration.inSeconds.remainder(60);

    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}
