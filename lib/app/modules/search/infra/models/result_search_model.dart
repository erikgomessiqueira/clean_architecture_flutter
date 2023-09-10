import 'dart:convert';

import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';

class ResultUserSearchModel extends ResultUserSearch {
  ResultUserSearchModel({
    required super.avatar,
    required super.name,
    required super.nickname,
    required super.numberRepositories,
  });

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'name': name,
      'nickname': nickname,
      'numberRepositories': numberRepositories,
    };
  }

  String toJson() => jsonEncode(toMap());

  static ResultUserSearchModel fromMap(Map<String, dynamic> map) {
    return ResultUserSearchModel(
      avatar: map['avatar'],
      name: map['name'],
      nickname: map['nickname'],
      numberRepositories: map['numberRepositories'],
    );
  }

  static ResultUserSearchModel fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

}
