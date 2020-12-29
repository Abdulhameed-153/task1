class Shops {
  String nextPageUrl;
  int id;
  String name;
  String image;
  String description;
  String phone;
  String email;
  dynamic website;
  String address;
  double longitude;
  num latitude;
  String createdAt;
  String updatedAt;
  int isOn;
  int rate;
  int ratersCount;
  int soldCount;
  dynamic userDistances;
  int credit;
  dynamic shopSerialNumber;
  dynamic licenseImage;
  dynamic licenseEndDate;
  String doorStartAt;
  String doorCloseAt;
  int productCount;
  int salesCount;
  int ordersCount;

  Shops(
      {this.nextPageUrl,
      this.id,
      this.name,
      this.image,
      this.description,
      this.phone,
      this.email,
      this.website,
      this.address,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt,
      this.isOn,
      this.rate,
      this.ratersCount,
      this.soldCount,
      this.userDistances,
      this.credit,
      this.shopSerialNumber,
      this.licenseImage,
      this.licenseEndDate,
      this.doorStartAt,
      this.doorCloseAt,
      this.productCount,
      this.salesCount,
      this.ordersCount});

  Shops.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    phone = json['Phone'];
    email = json['email'];
    website = json['website'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['Latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isOn = json['is_On'];
    rate = json['rate'];
    ratersCount = json['raters_count'];
    soldCount = json['sold_count'];
    userDistances = json['user_distances'];
    credit = json['Credit'];
    shopSerialNumber = json['shopSerialNumber'];
    licenseImage = json['licenseImage'];
    licenseEndDate = json['licenseEndDate'];
    doorStartAt = json['doorStartAt'];
    doorCloseAt = json['doorCloseAt'];
    productCount = json['ProductCount'];
    salesCount = json['SalesCount'];
    ordersCount = json['OrdersCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_url'] = this.nextPageUrl;
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['Phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_On'] = this.isOn;
    data['rate'] = this.rate;
    data['raters_count'] = this.ratersCount;
    data['sold_count'] = this.soldCount;
    data['user_distances'] = this.userDistances;
    data['Credit'] = this.credit;
    data['shopSerialNumber'] = this.shopSerialNumber;
    data['licenseImage'] = this.licenseImage;
    data['licenseEndDate'] = this.licenseEndDate;
    data['doorStartAt'] = this.doorStartAt;
    data['doorCloseAt'] = this.doorCloseAt;
    data['ProductCount'] = this.productCount;
    data['SalesCount'] = this.salesCount;
    data['OrdersCount'] = this.ordersCount;
    return data;
  }
}
