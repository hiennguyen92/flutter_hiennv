import 'dart:convert';
import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/services/cache/cache_service.dart';

class AuthInfo extends BaseChangeNotifier {


  final CacheService _cacheService;

  Token? _token;

  Token? get token => _token;

  set token(Token? token) {
    this._token = token;
    notifyListeners();
  }

  AuthInfo(this._cacheService);

  Future<bool> load() async {
    String? jsonToken = await _cacheService.get('token');
    this._token =
        jsonToken != null ? Token.fromJson(jsonDecode(jsonToken)) : null;
    notifyListeners();
    return this._token != null;
  }

  Future<bool> save(Token? newToken) async {
    bool isSaved = await _cacheService.save(
        'token', newToken != null ? jsonEncode(newToken) : null);
    if (isSaved) {
      this._token = newToken;
      notifyListeners();
    }
    print('isSaved: $isSaved - $newToken');
    return isSaved;
  }

}
