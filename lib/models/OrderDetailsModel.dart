class OrderDetailsModel {
  int? orderId;
  String? pickupPlaceName;
  String? customerName;
  String? pickupAddress;
  String? deliverAddress;
  String? pickupMobileNumber;
  String? deliverMobileNumber;
  double? pickupLatitude;
  double? pickupLongitude;
  double? deliverLatitude;
  double? deliverLongitude;
  List<FoodItem>? orderedItems;
  double? totalAmount;
  String? orderStatus;

  OrderDetailsModel(
      {this.orderId,
      this.pickupPlaceName,
      this.customerName,
      this.pickupAddress,
      this.deliverAddress,
      this.pickupMobileNumber,
      this.deliverMobileNumber,
      this.pickupLatitude,
      this.pickupLongitude,
      this.deliverLatitude,
      this.deliverLongitude,
      this.orderedItems,
      this.totalAmount,
      this.orderStatus});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['orderId'] = orderId;
    data['pickupPlaceName'] = pickupPlaceName;
    data['customerName'] = customerName;
    data['pickupAddress'] = pickupAddress;
    data['deliverAddress'] = deliverAddress;
    data['pickupMobileNumber'] = pickupMobileNumber;
    data['deliverMobileNumber'] = deliverMobileNumber;
    data['pickupLatitude'] = pickupLatitude;
    data['pickupLongitude'] = pickupLongitude;
    data['deliverLatitude'] = deliverLatitude;
    data['deliverLongitude'] = deliverLongitude;
    data['orderedItems'] = orderedItems!.map((v) => v.toMap()).toList();
    data['totalAmount'] = totalAmount;
    data['orderStatus'] = orderStatus;
    return data;
  }

  OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    orderId = map['orderId'];
    pickupPlaceName = map['pickupPlaceName'];
    customerName = map['customerName'];
    pickupAddress = map['pickupAddress'];
    deliverAddress = map['deliverAddress'];
    pickupMobileNumber = map['pickupMobileNumber'];
    deliverMobileNumber = map['deliverMobileNumber'];
    pickupLatitude = map['pickupLatitude'];
    pickupLongitude = map['pickupLongitude'];
    deliverLatitude = map['deliverLatitude'];
    deliverLongitude = map['deliverLongitude'];

    if (map['orderedItems'] != null) {
      orderedItems = <FoodItem>[];
      map['orderedItems'].forEach((v) {
        orderedItems!.add(FoodItem.fromMap(v));
      });
    }
    totalAmount = map['totalAmount'];
    orderStatus = map['orderStatus'];
  }
}

class FoodItem {
  int? itemId;
  String? foodItemName;
  int? quantity;
  double? price;
  String? image;

  FoodItem(
      {this.itemId, this.foodItemName, this.quantity, this.price, this.image});

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'foodItemName': foodItemName,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      itemId: map['itemId'],
      foodItemName: map['foodItemName'],
      quantity: map['quantity'],
      price: map['price'],
      image: map['image'],
    );
  }
}

List<OrderDetailsModel> dummyOngoingOrderList = [
  OrderDetailsModel(
      orderId: 1234567890,
      pickupPlaceName: 'Big Bites',
      customerName: 'Jhon Deo Michael',
      pickupAddress: '314 79th St Rite Aid, Brooklyn, NY, 11209',
      deliverAddress: '314 79th St Rite Aid, Brooklyn, NY, 11209',
      orderedItems: [
        FoodItem(foodItemName: 'Italian Pizza', quantity: 1, price: 100),
        FoodItem(foodItemName: 'Veg Burger Pizza', quantity: 1, price: 50)
      ],
      totalAmount: 150,
      orderStatus: 'Ongoing',
      pickupMobileNumber: '9022757382',
      deliverMobileNumber: '8828995647',
      pickupLatitude: 10.360540,
      pickupLongitude: 77.987510,
      deliverLatitude: 22.298340,
      deliverLongitude: 70.786873),
  OrderDetailsModel(
      orderId: 1234567891,
      pickupPlaceName: 'Apple Bites',
      customerName: 'Jhon Deo Michael',
      pickupAddress: '314 79th St Rite Aid, Brooklyn, NY, 11209',
      deliverAddress: '314 79th St Rite Aid, Brooklyn, NY, 11209',
      orderedItems: [
        FoodItem(foodItemName: 'Margarita Pizza', quantity: 1, price: 100),
        FoodItem(foodItemName: 'Italian Pizza', quantity: 1, price: 100)
      ],
      totalAmount: 200,
      orderStatus: 'Ongoing',
      pickupMobileNumber: '9022757382',
      deliverMobileNumber: '8828995647',
      pickupLatitude: 10.360540,
      pickupLongitude: 77.987510,
      deliverLatitude: 22.298340,
      deliverLongitude: 70.786873),
];

List<OrderDetailsModel> dummyDeliveredOrdersList = [
  OrderDetailsModel(
      orderId: 1234567889,
      pickupPlaceName: 'Big Bites',
      customerName: 'Jhon Deo Michael',
      pickupAddress: '314 79th St Rite Aid, Brooklyn, NY, 11209',
      deliverAddress: '314 79th St Rite Aid, Brooklyn, NY, 11209',
      orderedItems: [
        FoodItem(foodItemName: 'Italian Pizza', quantity: 1, price: 100),
        FoodItem(foodItemName: 'Veg Burger Pizza', quantity: 1, price: 50)
      ],
      totalAmount: 150,
      orderStatus: 'Delivered',
      pickupMobileNumber: '9022757382',
      deliverMobileNumber: '8828995647',
      pickupLatitude: 10.360540,
      pickupLongitude: 77.987510,
      deliverLatitude: 22.298340,
      deliverLongitude: 70.786873),
];
