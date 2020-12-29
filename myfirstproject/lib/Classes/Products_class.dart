class Products {
  String nextPageUrl;
  int id;
  String name;
  String categories;
  String image;
  int price;
  String description;
  String unit;
  String createdAt;
  String updatedAt;

  Products(
      {this.nextPageUrl,
      this.id,
      this.name,
      this.categories,
      this.image,
      this.price,
      this.description,
      this.unit,
      this.createdAt,
      this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    nextPageUrl = json['next_page_url'];
    id = json['id'];
    name = json['name'];
    categories = json['categories'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    unit = json['unit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_url'] = this.nextPageUrl;
    data['id'] = this.id;
    data['name'] = this.name;
    data['categories'] = this.categories;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
