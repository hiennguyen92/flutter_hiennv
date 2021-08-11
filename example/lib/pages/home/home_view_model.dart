import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/models/user_response.dart';

class HomeViewModel extends BaseViewModel<HomeViewState> {

  HomeViewModel(BuildContext context)
      : super(context, HomeViewState());

  void increase() {
    state.counter += 1;
    notifyListeners();
  }

  Future<void> callGetApi() async {
    // Map<String, dynamic> json = await networkService.get('api/v1/users',
    //     baseUrl: 'https://610d6e6b48beae001747b854.mockapi.io',
    //     apiCallback: this,
    //     dataKey: 'dataX');
    // UserResponse usersResponse = UserResponse.fromJson(json);
    // print('userResponse: $usersResponse');
  }

}

class HomeViewState extends BaseViewState {
  int counter = 0;
}
