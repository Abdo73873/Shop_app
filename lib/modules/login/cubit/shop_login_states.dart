
import 'package:shop_app/models/login_,model.dart';

abstract class ShopLoginStates{}
class ShopInitializeLoginState extends ShopLoginStates{}
class ShopLoadingLoginState extends ShopLoginStates{}
class ShopSuccessesLoginState extends ShopLoginStates{
  final ShopLoginModel loginModel ;
  ShopSuccessesLoginState(this.loginModel);
}
class ShopErrorLoginState extends ShopLoginStates{
  final String error;
  ShopErrorLoginState(this.error);

}
class ShopChangeVisibilityState extends ShopLoginStates{}
class ShopChangeLanguageState extends ShopLoginStates{}
