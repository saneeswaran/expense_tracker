import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/screens/authendication/signin/login_page.dart';
import 'package:expense_tracker/screens/authendication/signup/register_page.dart';
import 'package:expense_tracker/util/transitions_animation.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        spacing: size.height * 0.01,
        children: [
          Hero(
            tag: 'onboard',
            child: Container(
              height: size.height * 0.7,
              width: size.width * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Constants.onboardingBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Image.asset(Constants.onboard, fit: BoxFit.contain),
              ),
            ),
          ),
          Text(
            "Spend Smarter\n Save More",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.07,
            width: size.width * 0.8,
            child: CustomElevatedButton(
              text: "Get Started",
              onPressed:
                  () => TransitionsAnimation.moveToNextPage(
                    context,
                    route: const RegisterPage(),
                  ),
            ),
          ),
          _alreadyHaveAnAccount(context),
        ],
      ),
    );
  }

  Widget _alreadyHaveAnAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
          onPressed:
              () => TransitionsAnimation.moveToNextPage(
                context,
                route: const LoginPage(),
              ),
          child: Text(
            "Login",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
