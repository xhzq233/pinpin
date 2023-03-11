/// pinpin - time_converter
/// Created by xhz on 3/5/23

class TimeConverter {
  static String fromSeconds(int time) {
    final date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return fromDate(date);
  }

  static String fromDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
  }

  static String timeDescription(DateTime date) {
    final t = DateTime.now().difference(date);
    if (t.inDays >= 30) {
      return '${t.inDays ~/ 30}月前';
    } else if (t.inDays >= 1) {
      return '${t.inDays}天前';
    } else if (t.inHours >= 1) {
      return '${t.inHours}小时前';
    } else if (t.inMinutes >= 1) {
      return '${t.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  static String timeDescriptionFromSeconds(int time) {
    final date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return timeDescription(date);
  }
}
