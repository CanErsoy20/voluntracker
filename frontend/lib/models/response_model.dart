class ResponseModel {
  int? status;
  String? message;
  dynamic data;

  ResponseModel({this.status, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}
