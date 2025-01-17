import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/singup_or_signin.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify/common/widget/button/basic_app_button.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.chooseModeBg),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(AppVectors.logo)),
                  const Spacer(),
                  const Text(
                    "Choose Mode",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap:()=> context.read<ThemeCubit>().updateTheme(ThemeMode.dark),
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xff30393C)
                                          .withOpacity(0.5)),
                                  child: SvgPicture.asset(
                                    AppVectors.moon,
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                             onTap:()=> context.read<ThemeCubit>().updateTheme(ThemeMode.light),

                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        const Color(0xff30393C).withOpacity(0.5),
                                  ),
                                  child: SvgPicture.asset(
                                    AppVectors.sun,
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Ligt Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupOrSignInPage()));
                    },
                    title: "Continue",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
