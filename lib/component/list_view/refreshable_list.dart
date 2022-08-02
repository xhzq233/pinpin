/// pinpin - refreshable_list
/// Created by xhz on 31/07/2022

import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pinpin/component/loading/load_more_indicator.dart';
import 'package:pinpin/component/refresh/refresh_header.dart';
import 'package:pinpin/model/load_more/data_refreshable_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class RefreshableSliverList<T, S> extends StatelessWidget {
  final RefreshableDataList<T, S> sourceList;
  final EdgeInsetsGeometry padding;
  final SliverGridDelegate? gridDelegate;
  final ExtendedListDelegate? extendedListDelegate;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? sliverHeader;

  const RefreshableSliverList({
    Key? key,
    required this.sourceList,
    this.sliverHeader,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.gridDelegate,
    this.extendedListDelegate,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PullToRefreshNotification(
        onRefresh: () async => await sourceList.refresh(true),
        maxDragOffset: 100,
        child: CustomScrollView(
          slivers: [
            if (null != sliverHeader) sliverHeader!,
            PullToRefreshContainer((info) => PullToRefreshHeader(info: info)),
            LoadingMoreSliverList(
              SliverListConfig(
                padding: padding,
                extendedListDelegate: extendedListDelegate,
                gridDelegate: gridDelegate,
                sourceList: sourceList,
                itemBuilder: itemBuilder,
                indicatorBuilder: (BuildContext context, IndicatorStatus status) => LoadingMoreIndicator(
                  status: status,
                  errorRefresh: () async => await sourceList.errorRefresh(),
                  isSliver: true,
                  fullScreenErrorCanRetry: true,
                ),
              ),
            )
          ],
        ));
  }
}
