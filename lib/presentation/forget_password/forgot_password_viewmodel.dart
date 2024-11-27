import 'dart:async';

import 'package:clean_architecture/presentation/common/state_render/state_render_impl.dart';
import 'package:clean_architecture/presentation/base/base_view_model.dart';

import '../../app/funcations.dart';
import '../../domain/usecase/forgot_password_usecase.dart';
import '../common/state_render/state_render.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController<String> _emailStreamController =
  StreamController<String>.broadcast();
  final StreamController<void> _isAllInputValidStreamController =
  StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  String email = "";

  // Input Methods
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Future<void> forgotPassword() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState.add(
          ErrorState(StateRenderType.POPUP_ERROR_STATE, failure.message));
    }, (authObject) {
      inputState.add(ContentState());
    });
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  // Output Streams
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  // Private Helpers
  bool _isAllInputValid() {
    return isEmailValid(email);
  }

  void _validate() {
    inputIsAllInputValid.add(null);
  }

  // Cleanup
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose(); // Call dispose from BaseViewModel
  }
}

// Interface Definitions
abstract class ForgotPasswordViewModelInput {
  Future<void> forgotPassword();

  void setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
