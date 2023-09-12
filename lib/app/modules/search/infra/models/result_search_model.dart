import 'dart:convert';

import 'package:clean_architecture_flutter/app/modules/search/domain/entities/result_user_search.dart';

class ResultUserSearchModel extends ResultSearch {
  ResultUserSearchModel({
    required super.avatar,
    required super.nickname,
  });

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'nickname': nickname,
    };
  }

  String toJson() => jsonEncode(toMap());

  static ResultUserSearchModel fromMap(Map<String, dynamic> map) {
    return ResultUserSearchModel(
      avatar: map['avatar_url'],
      nickname: map['login'],
    );
  }

  static ResultUserSearchModel fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

}
