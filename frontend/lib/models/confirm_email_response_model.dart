class ConfirmEmailResponseModel {
  bool? isConfirmed;

  ConfirmEmailResponseModel({this.isConfirmed});

  ConfirmEmailResponseModel.fromJson(Map<String, dynamic> json) {
    isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isConfirmed'] = isConfirmed;
    return data;
  }
}
