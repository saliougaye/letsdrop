import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/widgets/drop_list_item.dart';

class DropList extends StatelessWidget {
  const DropList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropsBloc, DropsState>(
      builder: (context, state) {
        if (state is DropsLoadingFailed) {
          return const Center(
            child: Text("Cannot Load Drops"),
          );
        }

        if (state is DropsLoaded) {
          return ListView(
            children: state.drops.map((e) => DropItem(drop: e)).toList(),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  
}
