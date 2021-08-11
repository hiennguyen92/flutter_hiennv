import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/utils/extension.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

abstract class BaseViewModel<T extends BaseViewState> extends BaseChangeNotifier {

  BuildContext context;
  late NetworkService _networkService = context.networkService();
  bool _isLoading = false;
  T _state;

  bool get isLoading => _isLoading;
  T get state => _state;
  NetworkService get networkService => _networkService;

  set isLoading(bool isLoading) {
    if (_isLoading != isLoading) {
      _isLoading = isLoading;
      this.notifyListeners();
    }
  }

  BaseViewModel(this.context, this._state);

}
