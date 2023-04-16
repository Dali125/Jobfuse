// To parse this JSON data, do
//
//     final messageGroup = messageGroupFromJson(jsonString);

import 'dart:convert';

MessageGroup messageGroupFromJson(String str) => MessageGroup.fromJson(json.decode(str));

String messageGroupToJson(MessageGroup data) => json.encode(data.toJson());

class MessageGroup {
  MessageGroup({
    required this.from,
    required this.to,
    required this.users,
  });

  String from;
  String to;
  Map<String, dynamic> users;

  factory MessageGroup.fromJson(Map<String, dynamic> json) => MessageGroup(
    from: json["from"],
    to: json["to"],
    users: Map.from(json["users"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "users": Map.from(users).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
