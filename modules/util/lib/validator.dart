/// pinpin - validator
/// Created by xhz on 06/09/2022

typedef Validator = String? Function(String);
typedef TextFiledLimitation = bool Function(String);

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}

class Validators {
  Validators._();

  static final _emailReg = RegExp('^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.(com|cn|net)\$');

  static Validator email = (String str) {
    if (str.isEmpty) {
      return "邮箱不能为空";
    } else if (!_emailReg.hasMatch(str)) {
      return '邮箱不合规范';
    } else {
      return null;
    }
  };

  static TextFiledLimitation maxNNumber(int n) {
    bool func(String str) {
      if (str.isEmpty) {
        return true;
      } else if (str.length <= n && hasMatch(str, r'^\d+$')) {
        final num = int.tryParse(str);
        return num != null;
      } else {
        return false;
      }
    }

    return func;
  }

  static Validator studentID = (String str) {
    if (str.isEmpty) {
      return "学号不能为空";
    } else if (str[0] == 'U' || str[0] == 'u' || str[0] == 'M' || str[0] == 'm') {
      final num = int.tryParse(str.substring(1));
      if (num != null && 201600000 < num && num < 202340000) {
        return null;
      } else {
        return "学号格式错误";
      }
    } else {
      return "学号应以u/U/m/M开头";
    }
  };

  static final _passwdReg = RegExp('[A-Za-z0-9]{6,16}');

  static Validator passwd = (String str) {
    if (str.isEmpty) {
      return "密码不能为空";
    } else if (!_passwdReg.hasMatch(str)) {
      return '密码不合规范，需6-16个字符且仅含英文与数字';
    } else {
      return null;
    }
  };

  static Validator cannotEmpty = (String str) {
    if (str.isEmpty) {
      return "不能为空";
    } else {
      return null;
    }
  };

  static final _qqReg = RegExp("[1-9]\\d{4,10}");
  static Validator qqNumber = (String str) {
    if (str.isNotEmpty) {
      if (!_qqReg.hasMatch(str)) {
        return 'QQ号码格式不符！';
      }
    }
    return null;
  };

  static final _telReg = RegExp("1[34578]\\d{9}");
  static Validator telNumber = (String str) {
    if (str.isNotEmpty) {
      if (!_telReg.hasMatch(str)) {
        return '电话号码格式不符！';
      }
    }
    return null;
  };

  static final _vxReg = RegExp("[a-zA-Z][a-zA-Z\\d_-]{5,19}");

  static Validator vxNumber = (String str) {
    if (str.isNotEmpty) {
      if (!_vxReg.hasMatch(str)) {
        return '微信号格式不符！';
      }
    }
    return null;
  };

  static final _codeReg = RegExp("\\d{6}");

  static Validator verifyCode = (String str) {
    if (!_codeReg.hasMatch(str)) {
      return '应为6位数字!';
    }
    return null;
  };
}
