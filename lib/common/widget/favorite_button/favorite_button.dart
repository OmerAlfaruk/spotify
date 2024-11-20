import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;

  const FavoriteButton({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
      builder: (context, state) {
        // Default to `songEntity.isFavorite` for initial state.
        bool isFavorite = songEntity.isFavorite;

        // Update `isFavorite` based on the state of the cubit.
        if (state is FavoriteButtonUpdated) {
          isFavorite = state.isFavorite;
        }

        return IconButton(
          onPressed: () {
            // Trigger the favorite update logic in the cubit.
            context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
            color: context.isDarkMode? AppColors.grey : AppColors.darkGrey, // Highlight active state.
            size: 25,
          ),
        );
      },
    );
  }
}
