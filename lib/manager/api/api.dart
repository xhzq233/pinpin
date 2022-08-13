/// pinpin - api
/// Created by xhz on 27/07/2022


enum Api {
  ///welcome

  // Type    int    `form:"Type" binding:"required"`   //若为-1，则为全部类型且Label必为-1
  // Label  int    `form:"Label" binding:"required"`  //若为-1,则为全部标签
  // Start  int64  `form:"Start" binding:"required"`   //若为-1，则为当前时间，为获取拼拼帖的更新最晚限制时间
  getPinPinData('/welcome/getPinpins'),
  // Title   string     `form:"Title" binding:"required"` 查询的关键词
  // Type   int       `form:"Type" binging:"required"`   //若为-1则为全部类型
  // Start   int64    `form:"Start" binding:"required"`   //若为-1，则为当前时间
  searchPinPinData('/welcome/searchPinpins'),
  // Type    int    `form:"Type" binding:"required"`   //若为-1，则为全部类型且Label必为-1
  // Label  int    `form:"Label" binding:"required"`  //若为-1,则为全部标签
  // Start  int64  `form:"Start" binding:"required"`   //若为-1，则为当前时间
  getValidPinPInData('/welcome/getPinpinsUnfinished'),
  getUploadFileToken('/welcome/uploadFile'),


  ///manage

  // Email                     用户学号  不可为空 无所谓大小写 10位字符
  // IsResetPassword    是否为更改密码  不可为空  填true或false  为字符串类型
  sendVerifyCode('/manage/sendVerifyCode'),
  // Email      string `form:"Email" binding:"required"` 用户的邮箱
  // VerifyCode  string `form:"VerifyCode" binding:"required"`    用户输入的验证码   不可为空  会与用户的邮箱进行匹配
  activateAccount('/manage/activation'),
  // Email               string 不可为空 限制为10个字符的学号，不需要加后缀，首字母大小写均可，后台来处理。
  // Username               string 不可为空
  // Password                string 不可为空
  // Image                      string 不可为空 存用户的头像url，前端应在之前已将该图片存入该url
  createUser('/manage/createUser'),
  // Email                  string `form:"Email" binding:"required"`    不可为空  学号
  // Password           string `form:"Password"binding:"required"`   不可为空
  signIn('/manage/signIn'),
  // Email                  string `form:"Email" binding:"required"`    不可为空  学号
  getUserInfo('/manage/getUserInfo'),


  /// change

  // 需要先调用发验证码的接口
  // Email       string `form:"Email" binding:"required"`  不可为空
  // VerifyCode  string `form:"VerifyCode" binding:"required"`  不可为空
  // NewPassword string `form:"NewPassword" binding:"required"`   不可为空
  changePassword('/manage/change/changePassword'),
  // Email       string `form:"Email" binding:"required"`  不可为空
  // Username string `form:"Username" binding:"required"`  不可为空
  changeUsername('/manage/change/changeUsername'),
  // Email       string `form:"Email" binding:"required"` 不可为空
  // NewImage   int64 `form:"NewImage" binding:"required"`  不可为空
  changeUserAvatar('/manage/change/changeImage'),
  // Email               string     `form:"Email" binding:"required"`
  // MasterIntroduction  string        `form:"MasterIntroduction" binding:"required"`
  changeUserDescription('/manage/change/changeBrief'),
  // Email               string     `form:"Email" binding:"required"`
  // ShowPinpin       string    `form:"ShowPinpin" binding:"required"` 是否展示拼拼历史
  // 成功返回ok及该用户所有个人主页信息
  changeProfileVisibility('/manage/change/changeShowHistory'),
  // Email               string     `form:"Email" binding:"required"`
  // MyTags           string   `form:"MyTags" binding:"required"` 用户的所有个人标签，类型为字符串,标签之间的分割方式由前端确定，后端只保存并返回这个字符串
  // 成功返回ok及该用户所有个人主页信息
  changeUserTags('/manage/change/changeMyTags'),
  // Email               string     `form:"Email" binding:"required"`
  // Background     string    `form:"Background" binding:"required"`  存背景图片的url,与头像的图片相同，需要前端先将图片存入该url,后端负责保存这个url
  // 成功返回ok及该用户所有个人主页信息
  changeUserBackground('/manage/change/changeBackground'),


  /// recruit

  // Title                  string     `form:"Title" binding:"required"`  标题
  // Type                  int          `form:"Type" binding:"required"`  拼拼帖类型   为int类型
  // Label                 int          `form:"Label" binding:"required"` 拼拼帖标签   为int类型
  // Deadline            time.Time  `form:"Deadline" binding:"required"`  截止日期  格式类似于2022-07-22T08:42:25.107Z
  // Description        string     `form:"Description" binding:"omitempty"` 描述
  // DemandingNum    int        `form:"DemandingNum" binding:"required"` 需要的总人数
  // NowNum                     int        `form:"NowNum" binding:"required"` 已有的人数
  // DemandingDescription   string`form:"DemandingDescription" binding:"omitempty"` 人员需求描述 可不填
  // TeamIntroduction          string     `form:"TeamIntroduction" binding:"omitempty"` 团队介绍  可以不填
  // 娱乐拼：剧本杀，密室逃脱，打游戏，看电影，KTV,一起听歌、音乐节live house,喝酒、约饭、锻炼、约拍、旅游，出行拼车、其它
  // 学习拼：比赛招募、自习约人、托雅组团、考研组团，学业求教、自学打卡、其它
  // Type: 1为娱乐拼，Label按上图从左到右从1开始递增；2为学习拼，Label按上图从左到右从1开始递增
  createPinpin('/manage/recruit/createPinpin'),
  // PinpinId                    uint       `form:"PinpinId" binding:"required"` 拼拼贴序号
  // 其它参数与创建拼拼帖相同
  // 需要把全部内容都传入而不是只传更新的内容
  updatePinpin('/manage/recruit/updatePinpin'),
  // PinpinId      uint  `form:"PinpinId" binding:"required"`
  // DemandingNum int `form:"DemandingNum" binding:"required"`
  // NowNum       int `form:"NowNum" binding:"required"`
  updatePinpinPersonQty('/manage/recruit/updatePinpinNum'),
  // 应该在私聊双方达成一致，拼成功时调用，让现有人数加一
  // PinpinId      uint  `form:"PinpinId" binding:"required"`
  addPinpinPersonQty('/manage/recruit/updatePinpinNum'),
  // PinpinId uint `form:"PinpinId" binding:"required,gte=0"
  deletePinpin('/manage/recruit/deletePinpin'),
  // PinpinId      uint  `form:"PinpinId" binding:"required"`
  // 成功返回ok及该拼拼帖所有信息
  getSpecifiedPinpin('/manage/recruit/getPinpinDetails'),

  // changeProfileVisibility('$_head/manage/change/changeShowHistory'),
  // changeProfileVisibility('$_head/manage/change/changeShowHistory'),
  // changeProfileVisibility('$_head/manage/change/changeShowHistory'),
  /// follow
  // 第一次调为关注，再次调为取消关注，以此类推
  followPinPin('/manage/follows/createFollow'),

  /// reply
  createReply('/manage/replies/createReply'),
  getAllReplys('/manage/replies/getReplies'),
  deleteReply('/manage/replies/deleteReply'),

  /// thumb up
  createThumbUp('/manage/thumbUps/createThumbUp'),
  cancelThumpUp('/manage/thumbUps/deleteThumbUp'),

  /// advice
  createReportUser('/manage/reports/createReportUser'),
  // Content         string `form:"Content" binding:"required"`  建议内容
  createReportPinPin('/manage/advice/create'),

  /// notice
  getNotice('/manage/notices/getNotice'),
  readNotice('/manage/notices/readNotice'),

  /// sys_notice
  // (不是用户创建，是运营者创建)
  createSysNotice('/manage/systemNotice/createSystemNotice'),
  getMySysNotice('/manage/systemNotice/getSystemNotice'),

  /// myself
  getMyPinPin('/manage/myself/getMyPinpin'),
  getMyFollow('/manage/myself/getMyFollow');

  const Api(this.val);

  static const head = 'https://pinpin.pivotstudio.cn/api';

  static const _get = 'GET';
  static const _put = 'PUT';
  static const _post = 'POST';
  static const _delete = 'DELETE';

  final String val;

  String get method {
    switch (this) {
      case Api.getPinPinData:
        return _get;
      case Api.searchPinPinData:
        return _get;
      case Api.getValidPinPInData:
        return _get;
      case Api.getUploadFileToken:
        return _get;
      case Api.sendVerifyCode:
        return _post;
      case Api.activateAccount:
        return _post;
      case Api.createUser:
        return _post;
      case Api.signIn:
        return _post;
      case Api.getUserInfo:
        return _get;
      case Api.changePassword:
        return _put;
      case Api.changeUsername:
        return _put;
      case Api.changeUserAvatar:
        return _put;
      case Api.changeUserDescription:
        return _put;
      case Api.changeProfileVisibility:
        return _put;
      case Api.changeUserTags:
        return _put;
      case Api.changeUserBackground:
        return _put;
      case Api.createPinpin:
        return _post;
      case Api.updatePinpin:
        return _put;
      case Api.updatePinpinPersonQty:
        return _put;
      case Api.addPinpinPersonQty:
        return _put;
      case Api.deletePinpin:
        return _delete;
      case Api.getSpecifiedPinpin:
        return _get;
      case Api.followPinPin:
        return _post;
      case Api.createReply:
        return _post;
      case Api.getAllReplys:
        return _get;
      case Api.deleteReply:
        return _delete;
      case Api.createThumbUp:
        return _post;
      case Api.cancelThumpUp:
        return _delete;
      case Api.createReportUser:
        return _post;
      case Api.createReportPinPin:
        return _post;
      case Api.getNotice:
        return _get;
      case Api.readNotice:
        return _post;
      case Api.createSysNotice:
        return _post;
      case Api.getMySysNotice:
        return _get;
      case Api.getMyPinPin:
        return _get;
      case Api.getMyFollow:
        return _get;
    }
    return name;
  }
}
