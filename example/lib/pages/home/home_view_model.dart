import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv_example/app_route.dart';
import 'package:flutter_hiennv_example/models/error.dart';
import 'package:flutter_hiennv_example/models/profile.dart';
import 'package:flutter_hiennv_example/models/profile_response.dart';
import 'package:flutter_hiennv_example/services/database_service.dart';
import 'package:flutter_hiennv_example/services/profile_api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends BaseViewModel<HomeViewState> with ApiCallback {
  late ProfileApiService profileApiService =
      ProfileApiService(networkService, authInfo);

  late DatabaseService databaseService = Provider.of(context, listen: false);

  HomeViewModel(BuildContext context) : super(context, HomeViewState());

  void increase() {
    state.counter += 1;
    notifyListeners();
  }

  Future<void> getProfileApiAndSave() async {
    ProfileResponse profileResponse = await profileApiService.getProfile(this);
    if (profileResponse.isSuccessful() && profileResponse.data != null) {
      state.profile = profileResponse.data;
      databaseService.profileRepository.insert(profileResponse.data!);
      notifyListeners();
    } else {
      Error? error = profileResponse.error;
      if (error != null && error.code == 401 && error.raw == 'jwt expired') {
        Fluttertoast.showToast(
            msg: error.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
        logout();
      }
    }
  }

  Future<void> getProfileFromSqlite() async {
    Profile? profile = await databaseService.profileRepository.get(1);
    state.profile = profile;
    notifyListeners();
  }

  void logout() async {
    await authInfo.clear();
    await databaseService.profileRepository.clear();
    appNavigationService.pushNamedAndRemoveUntil(AppRoute.loginScreen);
  }

  @override
  Future<void> onCompleted(String path, Map<String, dynamic> response) async {
    isLoading = false;
    appDialogService.hideLoading(force: true);
  }

  @override
  Future<void> onStart(String path) async {
    isLoading = true;
    appDialogService.showLoading(context, text: "Loading...");
  }
}

class HomeViewState extends BaseViewState {
  int counter = 0;

  Profile? profile;
}
