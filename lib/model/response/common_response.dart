import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  CommonResponse();

  late Map<String,dynamic> data;
  late String msg;
  
  factory CommonResponse.fromJson(Map<String,dynamic> json) => _$CommonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}
