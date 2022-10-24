class GetAllCartModel {
  bool? success;
  int? status;
  String? message;
  List<Data>? data;

  GetAllCartModel({this.success, this.status, this.message, this.data});

  GetAllCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? venueId;
  int? tableNo;
  int? status;
  List<CartItems>? items;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.venueId,
      this.tableNo,
      this.status,
      this.items,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venue_id'];
    tableNo = json['table_no'];
    status = json['status'];
    if (json['items'] != null) {
      items = <CartItems>[];
      json['items'].forEach((v) {
        items!.add(new CartItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['venue_id'] = this.venueId;
    data['table_no'] = this.tableNo;
    data['status'] = this.status;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CartItems {
  int? id;
  List<Product>? product;
  int? quantity;
  List<CartExtras>? extras;

  CartItems({this.id, this.product, this.quantity, this.extras});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
    quantity = json['quantity'];
    if (json['extras'] != null) {
      extras = <CartExtras>[];
      json['extras'].forEach((v) {
        extras!.add(new CartExtras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    if (this.extras != null) {
      data['extras'] = this.extras!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  int? venueId;
  int? categoryId;
  String? title;
  String? description;
  String? nutritionInfo;
  String? ingredients;
  int? price;
  int? halal;
  int? chilli;
  int? isNew;
  int? popular;
  int? vegetarian;
  int? time;
  String? tabImage;
  String? createdAt;
  String? updatedAt;
  List<Translations>? translations;
  List<Tags>? tags;
  List<MenuTypes>? menuTypes;
  List<CartExtras>? extras;

  Product(
      {this.id,
      this.venueId,
      this.categoryId,
      this.title,
      this.description,
      this.nutritionInfo,
      this.ingredients,
      this.price,
      this.halal,
      this.chilli,
      this.isNew,
      this.popular,
      this.vegetarian,
      this.time,
      this.tabImage,
      this.createdAt,
      this.updatedAt,
      this.translations,
      this.tags,
      this.menuTypes,
      this.extras});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venue_id'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    nutritionInfo = json['nutrition_info'];
    ingredients = json['ingredients'];
    price = json['price'];
    halal = json['halal'];
    chilli = json['chilli'];
    isNew = json['is_new'];
    popular = json['popular'];
    vegetarian = json['vegetarian'];
    time = json['time'];
    tabImage = json['tab_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['menu_types'] != null) {
      menuTypes = <MenuTypes>[];
      json['menu_types'].forEach((v) {
        menuTypes!.add(new MenuTypes.fromJson(v));
      });
    }
    if (json['extras'] != null) {
      extras = <CartExtras>[];
      json['extras'].forEach((v) {
        extras!.add(new CartExtras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['venue_id'] = this.venueId;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['nutrition_info'] = this.nutritionInfo;
    data['ingredients'] = this.ingredients;
    data['price'] = this.price;
    data['halal'] = this.halal;
    data['chilli'] = this.chilli;
    data['is_new'] = this.isNew;
    data['popular'] = this.popular;
    data['vegetarian'] = this.vegetarian;
    data['time'] = this.time;
    data['tab_image'] = this.tabImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.menuTypes != null) {
      data['menu_types'] = this.menuTypes!.map((v) => v.toJson()).toList();
    }
    if (this.extras != null) {
      data['extras'] = this.extras!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  String? title;
  String? description;
  int? active;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? productId;
  int? languageId;
  String? nutritionInfo;
  String? ingredients;

  Translations(
      {this.id,
      this.title,
      this.description,
      this.active,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.productId,
      this.languageId,
      this.nutritionInfo,
      this.ingredients});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    active = json['active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productId = json['product_id'];
    languageId = json['language_id'];
    nutritionInfo = json['nutrition_info'];
    ingredients = json['ingredients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['active'] = this.active;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_id'] = this.productId;
    data['language_id'] = this.languageId;
    data['nutrition_info'] = this.nutritionInfo;
    data['ingredients'] = this.ingredients;
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  int? createdBy;
  int? updatedBy;
  Null? createdAt;
  Null? updatedAt;
  int? venueId;
  Pivot? pivot;

  Tags(
      {this.id,
      this.name,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.venueId,
      this.pivot});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    venueId = json['venue_id'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? productId;
  int? tagId;

  Pivot({this.productId, this.tagId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['tag_id'] = this.tagId;
    return data;
  }
}

class MenuTypes {
  int? id;
  String? name;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? venueId;
  Pivot? pivot;

  MenuTypes(
      {this.id,
      this.name,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.venueId,
      this.pivot});

  MenuTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    venueId = json['venue_id'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot3 {
  int? productId;
  int? menuTypeId;

  Pivot3({this.productId, this.menuTypeId});

  Pivot3.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    menuTypeId = json['menu_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['menu_type_id'] = this.menuTypeId;
    return data;
  }
}

class CartExtras {
  int? id;
  String? name;
  int? price;
  int? venueId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  CartExtras(
      {this.id,
      this.name,
      this.price,
      this.venueId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  CartExtras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    venueId = json['venue_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['venue_id'] = this.venueId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot1 {
  int? productId;
  int? productExtraId;

  Pivot1({this.productId, this.productExtraId});

  Pivot1.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productExtraId = json['product_extra_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_extra_id'] = this.productExtraId;
    return data;
  }
}

class Pivot2 {
  int? cartItemId;
  int? productExtraId;

  Pivot2({this.cartItemId, this.productExtraId});

  Pivot2.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cart_item_id'];
    productExtraId = json['product_extra_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_item_id'] = this.cartItemId;
    data['product_extra_id'] = this.productExtraId;
    return data;
  }
}
