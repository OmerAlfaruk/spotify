import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widget/app_bar/common_app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/widget/get_playlist.dart';
import 'package:spotify/presentation/home/widget/news_songs.dart';
import 'package:spotify/presentation/profile/page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
 late TabController _tabController;


 @override
  void initState() {
   super.initState();
   _tabController=TabController(length: 4, vsync: this);


//
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        action: IconButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>const ProfilePage())), icon: Icon(Icons.person)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeArtistCard(),
            _tab(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                  children: [
                    const NewsSongs(),
                    Container(),
                    Container(),
                    Container(),
                  ]),
            ),
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeArtist)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(AppImages.homeArtist),
                ),),
          ],
        ),

      ),
    );
  }

  Widget _tab(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 60),

      child: TabBar(
        labelColor: context.isDarkMode?Colors.white:Colors.black,
          isScrollable: true,
          indicatorColor: AppColors.primary,

          controller: _tabController,
          tabs: const [

        Text('News',style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400
        ),),
        Text('Videos',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),),
        Text('Artists',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),),
        Text('Podcasts',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
        ),),
      ]),
    );
  }
}
