import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/strings.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/utils/addVerticalSpace.dart';
import 'package:letsdrop/utils/date_comparison.dart';
import 'package:letsdrop/widgets/drop_date_divider.dart';
import 'package:letsdrop/widgets/drop_list_item.dart';
import 'package:letsdrop/widgets/loading.dart';

class DropList extends StatelessWidget {
  const DropList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropsBloc, DropsState>(
      listener: (context, state) {
        String? message;
        if (state is DeleteDropState && !state.succeded) {
          message = AppStrings.DeleteDropFailedMessage;
        }

        if (state is DeleteDropState && state.succeded) {
          message = AppStrings.DeleteDropSuccessMessage;
        }

        if (message != null && message != "") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));

          context.read<DropsBloc>().add(LoadDrops());
        }
      },
      child: BlocBuilder<DropsBloc, DropsState>(
        builder: (context, state) {
          Widget widget2See;
          if (state is DropsLoadingFailed) {
            widget2See = _loadErrorWidget(context);
          } else if (state is DeleteDropState) {
            widget2See = _dropsList(context, state.drops);
          } else if (state is DropsLoaded) {
            widget2See = _dropsList(context, state.drops);
          } else {
            widget2See = const Loading();
          }

          return widget2See;
          
        },
      ),
    );
  }

  Widget _loadErrorWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addVerticalSpace(10),
          Text(
            AppStrings.WarningEmoji,
            style: Theme.of(context).textTheme.headline1,
          ),
          addVerticalSpace(10),
          Text(
            AppStrings.WarningMessageLoadDrops,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }

  Widget _dropsList(BuildContext context, List<Drop> drops) {
    if (drops.isEmpty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: 300,
          child: Text(
            AppStrings.EmptyDropList,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    List<Drop> justDropped = drops.where((el) => el.dropDate.isBefore(DateTime.now())).toList();
    for (var element in justDropped) {
      element.dropDate = DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day-3);
    }
    List<Drop> futureDrops = drops.where((el) => el.dropDate.isAfter(DateTime.now())).toList();

    return GroupedListView<Drop, DateTime>(
      elements: List.from(justDropped)..addAll(futureDrops),
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
