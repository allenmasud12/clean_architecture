import 'dart:async';

import 'package:clean_architecture/presentation/common/state_render/state_render_impl.dart';

abstract class BaseViewModel implements  BaseViewModelInput , BaseViewModelOutput{
StreamController _inputStateStreamController = StreamController<FlowState>.broadcast();

@override

  Sink get inputState => _inputStateStreamController.sink;

@override
Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState)=>flowState);

@override
  void dispose() {
    _inputStateStreamController.close();
  }
}
abstract class BaseViewModelInput{
  void start();
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutput{
Stream<FlowState> get outputState;
}