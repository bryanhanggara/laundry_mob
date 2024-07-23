import 'package:laundri/models/shop_model.dart';
import 'package:laundri/models/user_model.dart';

class OrderModel {
    int id;
    String claimCode;
    int userId;
    int shopId;
    String wheight;
    bool withPickup;
    bool withDelivery;
    String pickupAddress;
    String deliveryAddress;
    double total;
    String description;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    ShopModel shop;
    UserModel user;

    OrderModel({
        required this.id,
        required this.claimCode,
        required this.userId,
        required this.shopId,
        required this.wheight,
        required this.withPickup,
        required this.withDelivery,
        required this.pickupAddress,
        required this.deliveryAddress,
        required this.total,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.shop,
        required this.user,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        claimCode: json["claim_code"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        wheight: json["wheight"],
        withPickup: json["with_pickup"]==1,
        withDelivery: json["with_delivery"]==1,
        pickupAddress: json["pickup_address"],
        deliveryAddress: json["delivery_address"],
        total: json["total"]?.toDouble(),
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shop: ShopModel.fromJson(json["shop"]),
        user: UserModel.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "claim_code": claimCode,
        "user_id": userId,
        "shop_id": shopId,
        "wheight": wheight,
        "with_pickup": withPickup?1:0,
        "with_delivery": withDelivery?1:0,
        "pickup_address": pickupAddress,
        "delivery_address": deliveryAddress,
        "total": total,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shop": shop.toJson(),
        "user": user.toJson(),
    };
}