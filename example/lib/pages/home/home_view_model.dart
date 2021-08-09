import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/models/user_response.dart';

class HomeViewModel extends BaseViewModel<HomeViewState> with ApiCallback {
  late NetworkService _networkService;

  HomeViewModel(BuildContext context, NetworkService networkService)
      : _networkService = networkService,
        super(context, HomeViewState());

  void increase() {
    state.counter += 1;
    notifyListeners();
  }

  Future<void> callGetApi() async {
    Map<String, dynamic> json = await _networkService.get('api/v1/users',
        baseUrl: 'https://610d6e6b48beae001747b854.mockapi.io',
        apiCallback: this,
        dataKey: 'dataX');
    UserResponse usersResponse = UserResponse.fromJson(json);
    print('userResponse: $usersResponse');
  }

  @override
  Future<void> onApiError(error) async {
    //print('error: $error');
  }

  @override
  Future<void> onCompleted(String path, bool status) async {
    print('onCompleted: $path- $status');
  }

  @override
  Future<void> onStart(String path) async {
    print('onStart: $path');
  }
}

class HomeViewState extends BaseViewState {
  int counter = 0;
}
