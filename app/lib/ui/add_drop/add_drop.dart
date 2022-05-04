import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/theme.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/add_drop_form.dart';
import 'package:letsdrop/widgets/appbar.dart';

class AddNewDropScreen extends StatelessWidget {
  const AddNewDropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  addVerticalSpace(20),
                  const Appbar(name: "Add Drop"),
                  addVerticalSpace(10),
                  AddDropForm()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
