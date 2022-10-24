class AllTagsModel {
  bool? success;
  int? status;
  List<Tagg>? data;

  AllTagsModel({this.success, this.status, this.data});

  AllTagsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Tagg>[];
      json['data'].forEach((v) {
        data!.add(new Tagg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tagg {
  int? id;
  String? name;
  int? createdBy;
  int? updatedBy;
  Null? createdAt;
  Null? updatedAt;
  int? venueId;

  Tagg(
      {this.id,
      this.name,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.venueId});

  Tagg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??'no name';
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    venueId = json['venue_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['venue_id'] = this.venueId;
    return data;
  }
}
