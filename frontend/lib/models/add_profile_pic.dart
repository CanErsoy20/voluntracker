class AddProfileImageModel {
  int? userId;
  String? imageUrl;

  AddProfileImageModel({this.userId, this.imageUrl});

  AddProfileImageModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
