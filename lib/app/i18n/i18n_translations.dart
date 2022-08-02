/// pinpin - i18n_translations
/// Created by xhz on 27/07/2022
import 'package:get/get.dart';
import 'i18n_names.dart';

class I18nTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      I18n.title:'1037拼拼',
      I18n.join:'加入拼拼',
      I18n.takeALook:'我先逛逛',
      I18n.doubleClickExitHint: '再按一次退出',
      I18n.welcome:'1037拼拼欢迎你',
      I18n.notice:'提示',
    },
    'en_US': {
      I18n.title:'1037PinPin',
      I18n.join:'Join now',
      I18n.takeALook:'Just take a look',
      I18n.doubleClickExitHint: 'Return again to exit',
      I18n.welcome:'Welcome Pin Pin',
      I18n.notice:'Notice',
    },
  };
}
