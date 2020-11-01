import 'dart:convert';

NewsDetailModel newsDetailModelFromJson(String str) => NewsDetailModel.fromJson(json.decode(str));

String newsDetailModelToJson(NewsDetailModel data) => json.encode(data.toJson());

class NewsDetailModel {
    NewsDetailModel({
        this.status,
        this.message,
        this.data,
    });

    String status;
    String message;
    Data data;

    factory NewsDetailModel.fromJson(Map<String, dynamic> json) => NewsDetailModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.topic,
        this.detail,
        this.imageurl,
        this.createdAt,
        this.status,
    });

    String id;
    String topic;
    String detail;
    String imageurl;
    DateTime createdAt;
    String status;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        topic: json["topic"] == null ? null : json["topic"],
        detail: json["detail"] == null ? null : json["detail"],
        imageurl: json["imageurl"] == null ? null : json["imageurl"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "topic": topic == null ? null : topic,
        "detail": detail == null ? null : detail,
        "imageurl": imageurl == null ? null : imageurl,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "status": status == null ? null : status,
    };
}
