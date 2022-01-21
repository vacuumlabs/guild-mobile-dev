import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'models/account.dart';

const baseBatchSize = 20;

class BankDataRepository {
  BankDataRepository({
    required this.baseUrl,
    required this.httpClient,
  });

  final String baseUrl;
  final Client httpClient;

  Future<List<Account>> fetchAccounts({
    int startIndex = 0,
    int postLimit = baseBatchSize
  }) async {
    final response = await httpClient.get(
      Uri.https(
        baseUrl,
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Account.fromJson(json);
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<List<Account>> fetchDeposits({
    int startIndex = 0,
    int postLimit = baseBatchSize
  })  async {
    final response = await httpClient.get(
      Uri.https(
        baseUrl,
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Account.fromJson(json);
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}