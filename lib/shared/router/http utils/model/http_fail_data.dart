class HttpFailData {
  HttpFailData({this.success, this.message});

  HttpFailData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
