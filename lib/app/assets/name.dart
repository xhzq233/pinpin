import 'package:flutter/foundation.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

/// pinpin - name
/// Created by xhz on 2022/8/1

class AppAssets {
  AppAssets._();

  static const arrow_down = 'assets/arrow_down.png';
  static const arrow_right = 'assets/arrow_right.png';
  static const arrow_left = 'assets/back.png';
  static const arrow_left_white = 'assets/back_white.png';
  static const arrow_left_onclick = 'assets/back_onclick.png';
  static const bell = 'assets/bell.png';
  static const calendar = 'assets/calendar.png';
  static const calendar_thick = 'assets/calendar_thick.png';
  static const calendar_thin = 'assets/calendar_thin.png';
  static const cancel = 'assets/cancel.png';
  static const cancel_on_click = 'assets/cancel_on_click.png';
  static const clock = 'assets/clock.png';
  static const clock_thick = 'assets/clock_thick.png';
  static const clock_thin = 'assets/clock_thin.png';
  static const comment = 'assets/comment.png';
  static const comment_active = 'assets/comment_active.png';
  static const delete = 'assets/delete.png';
  static const delete_onclick = 'assets/delete_on_click.png';
  static const edit = 'assets/edit.png';
  static const edit_3x = 'assets/edit_3x.png';
  static const edit_onclick = 'assets/edit_on_click.png';
  static const edit_small = 'assets/edit_small.png';
  static const failed = 'assets/failed.png';
  static const heart = 'assets/heart.png';
  static const home_active = 'assets/home_active.png';
  static const home = 'assets/home.png';
  static const lock = 'assets/lock.png';
  static const more = 'assets/more.png';
  static const more_onclick = 'assets/more_on_click.png';
  static const more_white = 'assets/more_white.png';
  static const msg_white = 'assets/msg_white.png';
  static const notification_center_comment = 'assets/notification_center_comment.png';
  static const passwd_hide = 'assets/passwd_hide.png';
  static const passwd_hide_3x = 'assets/passwd_hide_3x.png';
  static const passwd_show = 'assets/passwd_show.png';
  static const passwd_show_3x = 'assets/passwd_show_3x.png';
  static const person_active = 'assets/person_active.png';
  static const person = 'assets/person.png';
  static const tack_pic = 'assets/pic.png';
  static const tack_pic_onclick = 'assets/pic_thick.png';
  static const search_white = 'assets/search.png';
  static const search = 'assets/search_.png';
  static const search_onclick = 'assets/search_onclick.png';
  static const share = 'assets/share.png';
  static const share_active = 'assets/share_active.png';
  static const star = 'assets/star.png';
  static const star_active = 'assets/star_active.png';
  static const success = 'assets/success.png';
  static const tag_background = 'assets/tag.png';
  static const three_line_horizontal = 'assets/tag_more.png';
  static const thumbs_active = 'assets/thumbs_active.png';
  static const thumbs_inactive = 'assets/thumbs_inactive.png';
  static const trash_active = 'assets/trash_active.png';
  static const trash_inactive = 'assets/trash_inactive.png';
  static const unlock = 'assets/unlock.png';
  static const profile = 'assets/profile.png';
  static const slide_button = 'assets/slide_button.png';

  static const _home = 'assets/home_tag/icon_big/';

  ///PPFilterLabel\(([-0-9]+)\, \'(.+)\'\, \'\$\{_home\}active\=.+\.png\'\, \'\$\{_home\}inactive\=.+\.png\'\)\;
  ///->
  ///$1:PPFilterLabel\($1\, \'$2\'\, \'\$\{_home\}active\=$2\.png\'\, \'\$\{_home\}inactive\=$2\.png\'\)\,
  static const labelMap = {
    PinPin.ppt_ett: {
      -1: PPFilterLabel(-1, '全部', '${_home}active=全部.png', '${_home}inactive=全部.png'),
      33: PPFilterLabel(33, '其他', '${_home}active=其他.png', '${_home}inactive=其他.png'),
      3: PPFilterLabel(3, 'KTV', '${_home}active=KTV.png', '${_home}inactive=KTV.png'),
      2: PPFilterLabel(2, '一起听歌', '${_home}active=一起听歌.png', '${_home}inactive=一起听歌.png'),
      5: PPFilterLabel(5, '出行拼车', '${_home}active=出行拼车.png', '${_home}inactive=出行拼车.png'),
      6: PPFilterLabel(6, '剧本杀', '${_home}active=剧本杀.png', '${_home}inactive=剧本杀.png'),
      7: PPFilterLabel(7, '喝酒', '${_home}active=喝酒.png', '${_home}inactive=喝酒.png'),
      9: PPFilterLabel(9, '密室逃脱', '${_home}active=密室逃脱.png', '${_home}inactive=密室逃脱.png'),
      11: PPFilterLabel(11, '旅游', '${_home}active=旅游.png', '${_home}inactive=旅游.png'),
      13: PPFilterLabel(13, '游戏', '${_home}active=游戏.png', '${_home}inactive=游戏.png'),
      14: PPFilterLabel(14, '看电影', '${_home}active=看电影.png', '${_home}inactive=看电影.png'),
      15: PPFilterLabel(15, '约饭', '${_home}active=约饭.png', '${_home}inactive=约饭.png'),
      19: PPFilterLabel(19, '锻炼', '${_home}active=锻炼.png', '${_home}inactive=锻炼.png'),
      20: PPFilterLabel(20, '音乐节', '${_home}active=音乐节.png', '${_home}inactive=音乐节.png'),
    },
    PinPin.ppt_study: {
      -1: PPFilterLabel(-1, '全部', '${_home}active=全部.png', '${_home}inactive=全部.png'),
      33: PPFilterLabel(33, '其他', '${_home}active=其他.png', '${_home}inactive=其他.png'),
      28: PPFilterLabel(28, '学业求教', '${_home}active=学业求教.png', '${_home}inactive=学业求教.png'),
      21: PPFilterLabel(21, '托雅组团', '${_home}active=托雅组团.png', '${_home}inactive=托雅组团.png'),
      22: PPFilterLabel(22, '比赛招募', '${_home}active=比赛招募.png', '${_home}inactive=比赛招募.png'),
      26: PPFilterLabel(26, '考研组团', '${_home}active=考研组团.png', '${_home}inactive=考研组团.png'),
      27: PPFilterLabel(27, '自习约人', '${_home}active=自习约人.png', '${_home}inactive=自习约人.png'),
      29: PPFilterLabel(29, '自学打卡', '${_home}active=自学打卡.png', '${_home}inactive=自学打卡.png'),
    }
  };

  //这里做一个排序变成一个数组，便于列表直接读取
  static final Map<int, List<PPFilterLabel>> labelArray = () {
    final List<PPFilterLabel> ett = () {
      final list = labelMap[PinPin.ppt_ett]!.values.toList();
      mergeSort(list, compare: (PPFilterLabel a, PPFilterLabel b) {
        return a.id - b.id;
      });
      return list;
    }();

    final List<PPFilterLabel> study = () {
      final list = labelMap[PinPin.ppt_study]!.values.toList();
      mergeSort(list, compare: (PPFilterLabel a, PPFilterLabel b) {
        return a.id - b.id;
      });
      return list;
    }();

    return {
      PinPin.ppt_ett: ett,
      PinPin.ppt_study: study,
    };
  }();
}

class PPFilterLabel {
  const PPFilterLabel(this.id, this.title, this.activeImg, this.inactiveImg);

  final String title;
  final int id;
  final String activeImg;
  final String inactiveImg;

  @override
  String toString() {
    return '{$id - $title}';
  }
}
