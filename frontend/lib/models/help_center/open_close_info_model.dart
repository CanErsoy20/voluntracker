class OpenCloseInfo {
  String? start;
  String? end;

  OpenCloseInfo({this.start, this.end});

  OpenCloseInfo.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
