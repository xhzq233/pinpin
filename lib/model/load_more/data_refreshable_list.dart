/// pinpin - data_refreshable_list
/// Created by xhz on 30/07/2022

import 'package:dio/dio.dart';
import 'package:loading_more_list/loading_more_list.dart';

abstract class RefreshableListAdapter<T, S> extends LoadingMoreBase<T> {
  bool initData = false;
  S? nextDataPointer;

  @override
  bool get hasMore => !initData || null != nextDataPointer;
  final CancelToken _cancelToken = CancelToken();

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    initData = false;
    nextDataPointer = null;
    final result = super.refresh(notifyStateChanged);
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    if (!initData) {
      final res = await init(_cancelToken);
      if (null != res) {//returning an empty array also indicates successful initialization
        addAll(res);
        addAll(res);
        addAll(res);
        initData = true;
        return true;
      }
    } else {
      if (hasMore) {
        final res = await next(_cancelToken);
        if (null != res) {//returning an empty array also indicates successful initialization
          addAll(res);
          addAll(res);
          return true;
        }
      }
    }
    return false;
  }

  Future<List<T>?> init(CancelToken cancelToken);

  //调用此函数时 nextDataPointer 必不为null
  Future<List<T>?> next(CancelToken cancelToken);

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
