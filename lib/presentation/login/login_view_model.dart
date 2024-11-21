import 'dart:async';

import 'package:clean_architecture/domain/usecase/login_usecase.dart';
import 'package:clean_architecture/presentation/base/base_view_model.dart';

import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  // StreamControllers
  final StreamController<String> _userNameStreamController =
  StreamController.broadcast();
  final StreamController<String> _passwordStreamController =
  StreamController.broadcast();
  final StreamController<void> _isAllInputsValidStreamController =
  StreamController.broadcast();
  final StreamController<bool> isUserLoggedInSuccessfullyStreamController =
  StreamController.broadcast();

  LoginObject _loginObject = LoginObject("", "");
  final LoginUseCase? _loginUseCase;

  // Constructor
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    // Close all StreamControllers
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    if (_loginUseCase == null) {
      print("LoginUseCase is not initialized!");
      return;
    }

    // Call the use case
    final result = await _loginUseCase!.execute(
      LoginUseCaseInput(_loginObject.userName, _loginObject.password),
    );

    // Handle result using fold
    result.fold(
          (failure) {
        // Left (failure)
        print("Login failed: ${failure.message}");
        isUserLoggedInSuccessfullyStreamController.add(false);
      },
          (authentication) {
        // Right (success)
        print("Login successful: ${authentication.user?.name}");
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(_isPasswordValid);

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameStreamController.stream.map(_isUsernameValid);

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    _validate();
  }

  @override
  void setUserName(String username) {
    inputUserName.add(username);
    _loginObject = _loginObject.copyWith(userName: username);
    _validate();
  }

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // Private functions
  void _validate() {
    inputIsAllInputValid.add(null); // Trigger input validation
  }

  bool _isUsernameValid(String userName) {
    return userName.isNotEmpty && userName.length >= 3;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  bool _areAllInputsValid() {
    return _isPasswordValid(_loginObject.password) &&
        _isUsernameValid(_loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  void setUserName(String username);

  void setPassword(String password);

  void login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
