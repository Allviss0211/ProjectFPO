class Product {
  String id;
  String name;
  String description;
  String image;
  int price;
  int quantity;
  int minQuantity;
  String manufacturerId;
  String categoryId;
  String tag;
  int rewardPoint;
  DateTime inDate;
  String seo;
  String weight;
  int isActive;
  String document;
  bool isReward;
  String feature;

  Product({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.minQuantity,
    this.manufacturerId,
    this.categoryId,
    this.tag,
    this.rewardPoint,
    this.inDate,
    this.seo,
    this.weight,
    this.isActive,
    this.document,
    this.isReward,
    this.feature,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    price: json["price"],
    quantity: json["quantity"],
    minQuantity: json["minQuantity"],
    manufacturerId: json["manufacturerId"],
    categoryId: json["categoryId"],
    tag: json["tag"],
    rewardPoint: json["rewardPoint"],
    inDate: DateTime.parse(json["inDate"]),
    seo: json["seo"],
    weight: json["weight"],
    isActive: json["isActive"],
    document: json["document"],
    isReward: json["isReward"],
    feature: json["feature"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "quantity": quantity,
    "minQuantity": minQuantity,
    "manufacturerId": manufacturerId,
    "categoryId": categoryId,
    "tag": tag,
    "rewardPoint": rewardPoint,
    "inDate": inDate,
    "seo": seo,
    "weight": weight,
    "isActive": isActive,
    "document": document,
    "isReward": isReward,
    "feature": feature,
  };
}

