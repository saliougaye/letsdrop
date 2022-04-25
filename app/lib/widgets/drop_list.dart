import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/widgets/date_divider.dart';
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

          return GroupedListView<Drop, DateTime>(
            elements: state.drops, 
            groupBy: (element) => element.dropDate,
            itemBuilder: (context, element) => DropItem(drop: element),
            groupSeparatorBuilder: (value) => DateDivider(date: value),
            itemComparator: (element1, element2) => element1.album.compareTo(element2.album),
            useStickyGroupSeparators: false,
            floatingHeader: false,
            order: GroupedListOrder.ASC,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  
}
