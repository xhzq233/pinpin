/// pinpin - load_more_list
/// Created by xhz on 30/07/2022
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pinpin/component/loading/load_more_indicator.dart';
import 'package:pinpin/model/load_more/data_refreshable_list.dart';

class LoadMoreListView<T, S> extends StatelessWidget {
  final RefreshableListAdapter<T, S> sourceList;
  final EdgeInsetsGeometry padding;
  final SliverGridDelegate? gridDelegate;
  final ExtendedListDelegate? extendedListDelegate;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  const LoadMoreListView({
    Key? key,
    required this.sourceList,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.gridDelegate,
    this.extendedListDelegate,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingMoreList(
      ListConfig(
        padding: padding,
        showGlowLeading: false,
        showGlowTrailing: false,
        primary: true,
        itemBuilder: itemBuilder,
        sourceList: sourceList,
        extendedListDelegate: extendedListDelegate,
        gridDelegate: gridDelegate,
        itemCountBuilder: (int count) => sourceList.length,
        indicatorBuilder: (BuildContext context, IndicatorStatus status) => LoadingMoreIndicator(
          status: status,
          errorRefresh: () async => await sourceList.errorRefresh(),
        ),
      ),
    );
  }
}
