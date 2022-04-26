import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/widgets/drop_date_divider.dart';
import 'package:letsdrop/widgets/drop_list_item.dart';

class DropList extends StatelessWidget {
  const DropList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropsBloc, DropsState>(
      listener: (context, state) {

        if (state is DeleteDropFailed) {
            const snackBar = SnackBar(content: Text("Can't Delete Drop. Retry Later"));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          // if (state is DropsLoaded) {
          //   const snackBar = SnackBar(content: Text("Drop Deleted"));

          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // }
      },
      child: BlocBuilder<DropsBloc, DropsState>(
        builder: (context, state) {
          if (state is DropsLoadingFailed) {
            return const Center(
              child: Text("Cannot Load Drops"),
            );
          }

          if (state is DeleteDropFailed) {
            return _dropsList(state.drops);
          }

          if (state is DropsLoaded) {
            return _dropsList(state.drops);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  GroupedListView<Drop, DateTime> _dropsList(List<Drop> drops) {
    return GroupedListView<Drop, DateTime>(
      elements: drops,
      groupBy: (element) => element.dropDate,
      itemBuilder: (context, element) => DropItem(
        drop: element,
        onDismiss: (drop) {
          context.read<DropsBloc>().add(DeleteDrop(drop: drop));
        },
      ),
      groupSeparatorBuilder: (value) => DropDateDivider(date: value),
      itemComparator: (element1, element2) =>
          element1.album.compareTo(element2.album),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.ASC,
      shrinkWrap: true,
    );
  }
}
