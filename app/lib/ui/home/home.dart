import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/colors.dart';
import 'package:letsdrop/constants/routes.dart';
import 'package:letsdrop/constants/theme.dart';
import 'package:letsdrop/widgets/drop_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (themeContext, state) {
        return Scaffold(
          backgroundColor: Theme.of(themeContext).backgroundColor,
          appBar: AppBar(
            title: Text(
              "Good Morning User",
              style: Theme.of(themeContext).textTheme.headline1,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  themeContext.read<ThemeBloc>().add(ThemeEvent(
                      appTheme: state.appTheme == AppTheme.light
                          ? AppTheme.dark
                          : AppTheme.light));
                },
                icon: Icon(state.appTheme == AppTheme.light
                    ? Icons.wb_sunny
                    : Icons.nights_stay),
              )
            ],
            backgroundColor: const Color(0x44000000),
            elevation: 0,
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
            child: const DropList(),
          ),
          bottomNavigationBar: Padding(
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
                    style: TextStyle(
                      fontSize: 25
                    ),
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
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ),
              ],
              currentIndex: 1,
              onTap: (index) {
                if(index == 0) {
                  Navigator.pushNamed(context, AppRoutes.Add);
                }
              },
              isFloating: true,
            ),
          ),
        );
      },
    );
  }
}
