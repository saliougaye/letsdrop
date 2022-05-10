import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/widgets/drop_date_divider.dart';
import 'package:letsdrop/widgets/drop_list_item.dart';
import 'package:letsdrop/widgets/loading.dart';

class DropList extends StatelessWidget {
  const DropList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropsBloc, DropsState>(
      listener: (context, state) {
        if (state is DeleteDropState && !state.succeded) {
          const snackBar = SnackBar(
            content: Text("Can't Delete Drop. Retry Later"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is DeleteDropState && state.succeded) {
          const snackBar = SnackBar(
            content: Text("Drop Deleted"),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        context
            .read<DropsBloc>().add(LoadDrops());
      },
      child: BlocBuilder<DropsBloc, DropsState>(
        builder: (context, state) {
          Widget widget2See;
          if (state is DropsLoadingFailed) {
            widget2See = _loadErrorWidget();
          } else if (state is DeleteDropState) {
            widget2See = _dropsList(state.drops);
          } else if (state is DropsLoaded) {
            widget2See =  _dropsList(state.drops);
          } else {
            widget2See = const Loading();
          }

          
          return RefreshIndicator(
            child: widget2See, 
            onRefresh: () {
              context.read<DropsBloc>().add(LoadDrops());

              return Future.delayed(
                const Duration(seconds: 1)
              );
            }
          );
        },
      ),
    );
  }

  Widget _loadErrorWidget() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addVerticalSpace(10),
              Text(
                "⚠️",
                style: Theme.of(context).textTheme.headline1,
              ),
              addVerticalSpace(10),
              Text(
                "Sorry but we have a problem",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                ' Retry later',
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _dropsList(List<Drop> drops) {
    if (drops.isEmpty) {
      return const Text(
        'No drop saved. Try to add one',
      );
    }

    return GroupedListView<Drop, DateTime>(
      elements: drops,
      groupBy: (element) => element.dropDate,
      itemBuilder: (context, element) => DropItem(
        drop: element,
        onDismiss: (drop) {
          context
            .read<DropsBloc>().add(DeleteDrop(drop: drop));
        },
      ),
      groupSeparatorBuilder: (value) => DropDateDivider(date: value),
      itemComparator: (element1, element2) =>
          element1.album.compareTo(element2.album),
      useStickyGroupSeparators: false,
      floatingHeader: false,
      order: GroupedListOrder.ASC,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }
}
