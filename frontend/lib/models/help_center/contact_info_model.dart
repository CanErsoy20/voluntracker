class ContactInfo {
  String? phone;
  String? address;
  String? email;

  ContactInfo({this.phone, this.address, this.email});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['address'] = address;
    data['email'] = email;
    return data;
  }
}
