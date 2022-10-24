class VenueLoginModel {
  bool? success;
  int? status;
  Venue? venue;

  VenueLoginModel({this.success, this.status, this.venue});

  VenueLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    return data;
  }
}

class Venue {
  int? id;
  String? key;
  String? title;
  String? address;
  int? totalTables;

  Venue({this.id, this.key, this.title, this.address, this.totalTables});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    title = json['title'];
    address = json['address'];
    totalTables = json['total_tables'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['title'] = this.title;
    data['address'] = this.address;
    data['total_tables'] = this.totalTables;
    return data;
  }
}
