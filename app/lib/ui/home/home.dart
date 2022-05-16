import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/routes.dart';
import 'package:letsdrop/models/user.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/appbar.dart';
import 'package:letsdrop/widgets/drop_list.dart';

class Home extends StatelessWidget {
  final SpotifyUser user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (themeContext, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(themeContext).backgroundColor,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    addVerticalSpace(20),
                    Appbar(avatar: user.profileImage,),
                    addVerticalSpace(10),
                    Text(
                       "${_getAppBarGreeting()} ${user.name}",
                      style: Theme.of(themeContext).textTheme.headline1,
                    ),
                    addVerticalSpace(20),
                    const DropList(),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.Add);
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }


  String _getAppBarGreeting() {
    final now = DateTime.now();

    if(now.hour >= 6 && now.hour <= 12) {
      return "Good morning";
    }

    if(now.hour > 12 && now.hour <= 19) {
      return "Good afternoon";
    }

    return "Good evening";

  }
}
