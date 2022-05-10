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
  Home({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (themeContext, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(themeContext).backgroundColor,
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  addVerticalSpace(20),
                  Appbar(name: "Good Morning ${user.name}", avatar: user.profileImage,),
                  addVerticalSpace(10),
                  const DropList(),
                ],
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
}
