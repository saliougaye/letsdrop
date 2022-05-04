import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/theme.dart';
import 'package:letsdrop/widgets/add_drop_form.dart';

class AddNewDropScreen extends StatelessWidget {
  const AddNewDropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(
              "Add Drop",
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: const Color(0x44000000),
            elevation: 0,
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: AddDropForm(),
          ),
        );
      },
    );
  }
}
