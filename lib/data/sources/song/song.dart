import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/songs/is_favorite_song.dart';
import 'package:spotify/service_locator/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSong();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSong();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSong() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy('releaseDate')
          .limit(6)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return left("An error ${e.toString()} occurred,please try again");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      print("Fetching playlists from Firestore...");
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("songs")
          .orderBy('releaseDate')
          .get();

      print("Data fetched: ${data.docs.length} documents found.");
      for (var element in data.docs) {
        print("Processing document: ${element.data()}");
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      print("Returning ${songs.length} songs.");
      return Right(songs);
    } catch (e, stackTrace) {
      print("Error occurred: ${e.toString()}");
      print(stackTrace);
      return Left("An error occurred: ${e.toString()}");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    late bool isFavorite;
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        await favoriteSong.docs.first.reference.delete();
        isFavorite = false;
      } else {
        firebaseFirestore
            .collection('users')
            .doc(uId)
            .collection('favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSong = await firebaseFirestore
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSong() async {
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      List<SongEntity> favoriteSongs=[];
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore
          .collection('users')
          .doc(uId)
          .collection('favorites')
          .get();
      for (var element in favoritesSnapshot.docs) {
        String songId=element['songId'];
        var song=await firebaseFirestore.collection('songs').doc(songId).get();
        SongModel songModel=SongModel.fromJson(song.data()!);
        songModel.isFavorite=true;
        songModel.songId=songId;
        favoriteSongs.add(songModel.toEntity());

      }
      return Right(favoriteSongs);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
