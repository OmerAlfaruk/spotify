import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widget/app_bar/common_app_bar.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/sign_in.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/presentation/profile/bloc/user_favorite_song_cubit.dart';
import 'package:spotify/presentation/profile/bloc/user_favorite_song_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';
import 'package:spotify/service_locator/service_locator.dart';

import '../../../core/configs/constants/app_urls.dart';
import '../../../domain/usecases/auth/logout_usecase.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Profile'),
        backgroundColor:
            context.isDarkMode ? Color(0xff2C2B2B) : AppColors.grey,
        action: IconButton(onPressed: ()async{
          await  sl<LogoutUseCase>().call();

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>SignInPage()), (route)=>false);
        }, icon: Icon(Icons.logout)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          SizedBox(
            height: 30,
          ),
          _favoriteSong(context)
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: BoxDecoration(
            color: context.isDarkMode ? Color(0xff2C2B2B) : AppColors.grey,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            )),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is ProfileInfoLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(state.userEntity.imageUrl!))),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(state.userEntity.email!),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  state.userEntity.fullName!,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
          if (state is ProfileInfoFailure) {
            return const Center(child: Text('Failed To Load please try again'));
          }
          return Container();
        }),
      ),
    );
  }

  Widget _favoriteSong(BuildContext context) {
    return BlocProvider(
      create: (_) => UserFavoriteSongCubit()..getUserFavoriteSong(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('FAVORITE SONGS'),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<UserFavoriteSongCubit, UserFavoriteSongState>(
              builder: (context, state) {
            if (state is UserFavoriteSongLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserFavoriteSongLoaded) {
              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return SongPlayerPage(songEntity: state.songs[index]);
                          }),),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        '${AppURls.coverFirestorage}${state.songs[index].artist} - ${state.songs[index].title}.jpg?${AppURls.mediaAlt}',
                                      ))),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.songs[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.songs[index].artist,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(state.songs[index].duration
                                    .toString()
                                    .replaceAll('.', ':')),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<UserFavoriteSongCubit>().removeFromFavorite(index);
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ]),
                    );
                  },
                  separatorBuilder: (context, state) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: state.songs.length);
            }
            if (state is UserFavoriteSongLoadFailure) {
              return Text('Please try again');
            }
            return Container();
          }),
        ]),
      ),
    );
  }
}
