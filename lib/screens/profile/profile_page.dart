import 'package:expense_tracker/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.45,
            width: size.width * 1,
            child: SizedBox(
              height: size.height * 0.40,
              width: size.width * 1,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.35,
                    width: size.width * 1,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Constants.backgroundRectangle),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.12,
                    left: size.width * 0.25,
                    child: Container(
                      height: size.height * 0.40,
                      width: size.width * 0.50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Constants.profile),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            itemCount: profileTiles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Icon(profileIcon[index])),
                title: Text(profileTiles[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
