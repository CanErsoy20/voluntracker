class BusiestHours {
  String? start;
  String? end;

  BusiestHours({this.start, this.end});

  BusiestHours.fromJson(Map<String, dynamic> json) {
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
