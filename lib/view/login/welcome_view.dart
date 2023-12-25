import 'package:flutter/material.dart';
import 'package:food_delivery/view/login/login_view.dart';
import 'package:food_delivery/view/login/sing_up_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    TColor.white
                        .withOpacity(0.7), // Adjust opacity here (0.0 to 1.0)
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    "assets/img/welcome_top_shape.png",
                    width: media.width,
                  ),
                ),
                Image.asset(
                  "assets/img/app_logo.png",
                  width: media.width * 0.55,
                  height: media.width * 0.55,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(
              height: media.width * 0.1,
            ),
            Text(
              "Explorez les meilleurs plats\n et une livraison rapide jusqu'à votre\ndomicile.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: media.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundButton(
                title: "Connexion",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 25),
            //   child: RoundButton(
            //     title: "Créer un Compte",
            //     type: RoundButtonType.textPrimary,
            //     onPressed: () {
            //        Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const SignUpView(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
