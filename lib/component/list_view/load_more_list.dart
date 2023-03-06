/// pinpin - load_more_list
/// Created by xhz on 30/07/2022
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/manager/load_more/data_refreshable_list.dart';

class LoadMoreListView<T, S> extends StatelessWidget {
  final RefreshableListAdapter<T, S> sourceList;
  final EdgeInsetsGeometry padding;
  final SliverGridDelegate? gridDelegate;
  final ExtendedListDelegate? extendedListDelegate;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  const LoadMoreListView({
    Key? key,
    required this.sourceList,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.gridDelegate,
    this.extendedListDelegate,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> func() async {
      await sourceList.refresh(true);
    }

    return RefreshIndicator(
      onRefresh: func,
      child: LoadingMoreList(
        ListConfig(
          physics: const ClampingScrollPhysics(),
          padding: padding,
          showGlowLeading: false,
          showGlowTrailing: false,
          primary: true,
          itemBuilder: itemBuilder,
          sourceList: sourceList,
          extendedListDelegate: extendedListDelegate,
          gridDelegate: gridDelegate,
          itemCountBuilder: (int count) => sourceList.length,
          indicatorBuilder: _buildIndicator,
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    const textStyle = AppTheme.headline5;

    Widget widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = const SizedBox();
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = const Text('Loading', style: textStyle);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = const CircularProgressIndicator();
        break;
      case IndicatorStatus.error:
        widget = InkWell(
          onTap: () => sourceList.errorRefresh,
          child: const Text('Load Error', style: textStyle),
        );
        break;
      case IndicatorStatus.noMoreLoad:
        widget = const Text('No more data', style: textStyle);
        break;
      case IndicatorStatus.empty:
        widget = const Text('Nothing here...', style: textStyle);
        return LayoutBuilder(
          builder: (_, layout) => SingleChildScrollView(
            child: SizedBox(
              height: layout.maxHeight * 0.8,
              child: Center(child: widget),
            ),
          ),
        );
      case IndicatorStatus.fullScreenError:
        widget = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Load Error', style: textStyle),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _refresh,
              child: const Text('Retry', style: textStyle),
            )
          ],
        );
        return LayoutBuilder(
          builder: (_, layout) => SingleChildScrollView(
            child: SizedBox(
              height: layout.maxHeight * 0.8,
              child: Center(child: widget),
            ),
          ),
        );
    }

    return Center(
      child: widget,
    );
  }

  VoidCallback get _refresh => sourceList.errorRefresh;
}
