import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/screens/bottom%20nav%20bar/bottom_navi_bar.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/util/transitions_animation.dart';
import 'package:expense_tracker/widgets/custom_elevated_button.dart';
import 'package:expense_tracker/widgets/custom_snack_bar.dart';
import 'package:expense_tracker/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  //service
  final AuthService auth = AuthService();
  //animations
  late AnimationController controller;
  late Animation<Offset> offset;

  //controller
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    offset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(controller);
    controller.forward();
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      final bool isSuccess = await auth.signUpUser(
        context: context,
        name: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (isSuccess && mounted) {
        TransitionsAnimation.moveToNextPageWithReplacement(
          context,
          route: const BottomNaviBar(),
        );
      } else {
        failedSnackBar("Register first", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 1,
          width: size.width * 1,
          color: Constants.mainColor,
          child: Column(
            spacing: size.height * 0.01,
            children: [
              SizedBox(height: size.height * 0.05),
              Hero(
                tag: 'onboard',
                child: Container(
                  height: size.height * 0.35,
                  width: size.width * 1,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Constants.onboard),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.05),
                  height: size.height * 0.40,
                  width: size.width * 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SlideTransition(
                    position: offset,
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: size.height * 0.02,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomTextFormField(
                            labelText: "user name",
                            controller: userNameController,
                          ),
                          CustomTextFormField(
                            labelText: "email",
                            controller: emailController,
                          ),
                          CustomTextFormField(
                            labelText: "password",
                            controller: passwordController,
                          ),

                          SizedBox(
                            height: size.height * 0.07,
                            width: size.width * 1,
                            child: CustomElevatedButton(
                              text: 'Submit',
                              onPressed: register,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
