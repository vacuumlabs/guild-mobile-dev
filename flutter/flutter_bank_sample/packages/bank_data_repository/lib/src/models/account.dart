import 'package:equatable/equatable.dart';

class Account extends Equatable {
  const Account({required this.id, required this.title, required this.body});

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];

  static Account fromJson(dynamic json) {
    return Account(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}