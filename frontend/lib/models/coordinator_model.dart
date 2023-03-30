class Coordinator {
  int? id;
  int? volunteerId;
  int? helpCenterId;

  Coordinator({this.id, this.volunteerId, this.helpCenterId});

  Coordinator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volunteerId = json['volunteerId'];
    helpCenterId = json['helpCenterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['volunteerId'] = volunteerId;
    data['helpCenterId'] = helpCenterId;
    return data;
  }
}
