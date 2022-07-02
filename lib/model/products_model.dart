// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

class ProductModel {
  ProductModel({
    required this.requestHash,
    required this.requestCached,
    required this.requestCacheExpiry,
    required this.apiDeprecation,
    required this.apiDeprecationDate,
    required this.apiDeprecationInfo,
    required this.results,
    required this.lastPage,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  bool apiDeprecation;
  DateTime apiDeprecationDate;
  String apiDeprecationInfo;
  List<Result> results;
  int lastPage;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        apiDeprecation: json["API_DEPRECATION"],
        apiDeprecationDate: DateTime.parse(json["API_DEPRECATION_DATE"]),
        apiDeprecationInfo: json["API_DEPRECATION_INFO"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        lastPage: json["last_page"],
      );
}

class Result {
  Result({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.airing,
    required this.synopsis,
    required this.type,
    required this.episodes,
    required this.score,
    required this.startDate,
    required this.endDate,
    required this.members,
    required this.rated,
  });

  int malId;
  String url;
  String imageUrl;
  String title;
  bool airing;
  String synopsis;
  String type;
  int episodes;
  double score;
  DateTime? startDate;
  DateTime? endDate;
  int members;
  String rated;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        malId: json["mal_id"],
        url: json["url"],
        imageUrl: json["image_url"],
        title: json["title"],
        airing: json["airing"],
        synopsis: json["synopsis"],
        type: json["type"] ?? "",
        episodes: json["episodes"],
        score: json["score"].toDouble(),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        members: json["members"],
        rated: json["rated"] ?? "",
      );
}
