import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = "",
  });

  static CategoryModel empty() =>
      CategoryModel(id: "", name: "", image: "", isFeatured: false);

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Image": image,
      "ParentId": parentId,
      "IsFeatured": isFeatured
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return CategoryModel.empty();

    return CategoryModel(
      id: document.id,
      name: data["Name"] ?? "",
      image: data["Image"] ?? "",
      isFeatured: data["IsFeatured"] ?? false,
    );
  }
}
