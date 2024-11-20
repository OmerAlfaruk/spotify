import 'package:spotify/domain/entities/song/song.dart';

abstract class UserFavoriteSongState {}

 class UserFavoriteSongLoading extends UserFavoriteSongState {}
 class UserFavoriteSongLoaded extends UserFavoriteSongState {
  final List<SongEntity> songs;

  UserFavoriteSongLoaded({required this.songs});
 }
 class UserFavoriteSongLoadFailure extends UserFavoriteSongState {}
