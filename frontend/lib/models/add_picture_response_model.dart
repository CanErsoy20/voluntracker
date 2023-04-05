class AddPictureResponseModel {
  String? imageUrl;

  AddPictureResponseModel({this.imageUrl});

  AddPictureResponseModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    return data;
  }
}
