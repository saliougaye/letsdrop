import 'package:flutter/material.dart';
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
    return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
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
                      style: Theme.of(context).textTheme.headline1,
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
