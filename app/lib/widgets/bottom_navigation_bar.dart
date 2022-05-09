import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:letsdrop/constants/routes.dart';

class BottomFloatingNavigationBar extends StatelessWidget {

  final String userImageUrl;
  const BottomFloatingNavigationBar({Key? key, required this.userImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
      child: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Colors.white,
        strokeColor: Colors.white,
        unSelectedColor: Colors.white,
        backgroundColor: Colors.black,
        borderRadius: const Radius.circular(20.0),
        blurEffect: true,
        opacity: 0.8,
        items: [
          CustomNavigationBarItem(
            icon: const Text(
              "➕",
              style: TextStyle(fontSize: 25),
            ),
          ),
          CustomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                userImageUrl,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: const Text(
              "📆",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
        currentIndex: 1,
        onTap: (index) async {
          if (index == 0) {
            Navigator.pushNamed(context, AppRoutes.Add);
          }
        },
        isFloating: true,
      ),
    );
  }
}
