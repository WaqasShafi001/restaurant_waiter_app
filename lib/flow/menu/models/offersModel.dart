class OffersModel {
  int? status;
  bool? success;
  List<Offers>? data =[];

  OffersModel({this.status, this.success, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Offers>[];
      json['data'].forEach((v) {
        data!.add(new Offers.fromJson(v));
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

class Offers {
  int? id;
  String? title;
  String? description;
  int? discount;
  String? image;
  List<Translations>? translations;
  String? createdAt;
  String? updatedAt;

  Offers(
      {this.id,
      this.title,
      this.description,
      this.discount,
      this.image,
      this.translations,
      this.createdAt,
      this.updatedAt});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']??'no title';
    description = json['description']??'no description';
    discount = json['discount']??0;
    image = json['image']??'';
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['image'] = this.image;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Translations {
  int? id;
  int? languageId;
  int? offerId;
  String? title;
  String? description;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Translations(
      {this.id,
      this.languageId,
      this.offerId,
      this.title,
      this.description,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    offerId = json['offer_id'];
    title = json['title']??'no title';
    description = json['description']??'no description';
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language_id'] = this.languageId;
    data['offer_id'] = this.offerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
