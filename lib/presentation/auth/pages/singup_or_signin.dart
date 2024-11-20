import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widget/app_bar/common_app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/common/widget/button/basic_app_button.dart';
import 'package:spotify/presentation/auth/pages/sign_in.dart';
import 'package:spotify/presentation/auth/pages/sign_up.dart';

class SignupOrSignInPage extends StatelessWidget {
  const SignupOrSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child:SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child:SvgPicture.asset(AppVectors.bottomPattern),
          ), Align(
            alignment: Alignment.bottomLeft,
            child:Image.asset(AppImages.authBg),
          ), Align(
            alignment: Alignment.center,

            child:Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(height: 55,),
                  const Text('Enjoy Listening To Music',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),
                  textAlign: TextAlign.center,),
                  const SizedBox(height: 21,),
                  const Text('Spotify is proprietary audio'
                      ' streaming and media service provider ',style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColors.grey

                  ),
                  textAlign: TextAlign.center,),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(child: BasicAppButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage())); }, title: 'Register',)),
                      SizedBox(width: 20,),

                      Expanded(child: TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInPage())); }, child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 16,
color: context.isDarkMode?Colors.white:Colors.black
                      ),),),),
                    ],
                  )
                ],
              ),
            ),
          ),


      ],),
    ));
  }
}
