class OrderCategoryModel {
  int? catId;
  String? category;

  OrderCategoryModel({this.catId, this.category});

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'category': category,
    };
  }

  factory OrderCategoryModel.fromMap(Map<String, dynamic> map) {
    return OrderCategoryModel(
      catId: map['catId'],
      category: map['category'],
    );
  }
}

List<OrderCategoryModel> dummyOrderCatList = [
  OrderCategoryModel(catId: 1, category: 'Ongoing'),
  OrderCategoryModel(catId: 2, category: 'Delivered')
];
