import 'package:dio/dio.dart';

class Categories {
  int id;
  int parentId;
  int order;
  String name;
  String slug;
  String createdAt;
  String updatedAt;
  String description;
  String image;

  Categories(
      {this.id,
      this.parentId,
      this.order,
      this.name,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    order = json['order'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['order'] = this.order;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

Future getCategories() async {
  try {
    String baseURL = 'http://80.211.24.15/api/';
    var responseCategor = await Dio().get(baseURL + 'getCategories');
    var dataCategor = responseCategor.data;
    var categor = dataCategor;
    return categor;
  } catch (e) {
    print(e);
  }
}

String baseURLImage = 'http://80.211.24.15/storage/';
String onecategor;
