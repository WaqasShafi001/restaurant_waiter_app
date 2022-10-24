class SocialLinksModel {
  int? status;
  bool? success;
  List<SocialData>? data;

  SocialLinksModel({this.status, this.success, this.data});

  SocialLinksModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <SocialData>[];
      json['data'].forEach((v) {
        data!.add(new SocialData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialData {
  int? id;
  int? venueId;
  String? title;
  String? link;
  String? icon;
  String? qrCode;
  String? createdAt;
  String? updatedAt;

  SocialData(
      {this.id,
      this.venueId,
      this.title,
      this.link,
      this.icon,
      this.qrCode,
      this.createdAt,
      this.updatedAt});

  SocialData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venue_id'];
    title = json['title']??'no title';
    link = json['link']??'';
    icon = json['icon']??'';
    qrCode = json['qr_code']??'';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['venue_id'] = this.venueId;
    data['title'] = this.title;
    data['link'] = this.link;
    data['icon'] = this.icon;
    data['qr_code'] = this.qrCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
