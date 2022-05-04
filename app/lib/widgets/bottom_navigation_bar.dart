import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:letsdrop/constants/routes.dart';

class BottomFloatingNavigationBar extends StatelessWidget {
  const BottomFloatingNavigationBar({Key? key}) : super(key: key);

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
            icon: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://i.scdn.co/image/ab6775700000ee85dee9cf3e1dec011d280d8fe8",
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
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, AppRoutes.Add);
          }
        },
        isFloating: true,
      ),
    );
  }
}
