
import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';

abstract class BaseViewModel<T extends BaseViewState> with ChangeNotifier {

  BuildContext context;
  bool _mounted = true;
  bool _isLoading = false;
  T _state;

  bool get mounted => _mounted;
  bool get isLoading => _isLoading;
  T get state => _state;

  set isLoading(bool isLoading) {
    if(_isLoading != isLoading){
      _isLoading = isLoading;
      this.notifyListeners();
    }
  }

  BaseViewModel(this.context, this._state);


  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if(_mounted){
      super.notifyListeners();
    }
  }

}