import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';

class HomeViewModel extends BaseViewModel<HomeViewState>{

  HomeViewModel(BuildContext context) : super(context, HomeViewState());


  void increase() {
    state.counter += 1;
    notifyListeners();
  }



}

class HomeViewState extends BaseViewState {

  int counter = 999;

}
