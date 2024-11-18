abstract class BaseViewModel implements  BaseViewModelInput , BaseViewModelOutput{

}
abstract class BaseViewModelInput{
  void start();
  void dispose();
}

abstract class BaseViewModelOutput{

}