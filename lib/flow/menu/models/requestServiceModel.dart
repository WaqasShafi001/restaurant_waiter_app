class RequestServiceModel {
  int? status;
  bool? success;
  String? messasge;

  RequestServiceModel({this.status, this.success, this.messasge});

  RequestServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    messasge = json['messasge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['messasge'] = this.messasge;
    return data;
  }
}
