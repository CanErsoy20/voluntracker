class ResponseModel {
  int? status;
  dynamic data;

  ResponseModel({this.status, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }
}
