
import 'package:shop_app/models/login_,model.dart';

abstract class ShopRegisterStates{}
class ShopInitializeRegisterState extends ShopRegisterStates{}
class ShopLoadingRegisterState extends ShopRegisterStates{}
class ShopSuccessesRegisterState extends ShopRegisterStates{
  final ShopLoginModel registerModel ;
  ShopSuccessesRegisterState(this.registerModel);
}
class ShopErrorRegisterState extends ShopRegisterStates{
  final String error;
  ShopErrorRegisterState(this.error);

}
class ShopChangeVisibilityState extends ShopRegisterStates{}
class ShopChangeLanguageState extends ShopRegisterStates{}
