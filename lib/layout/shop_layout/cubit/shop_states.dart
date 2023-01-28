
import 'package:shop_app/models/post_to_favorites_and_carts_model.dart';

abstract class ShopStates {}

class ShopInitializeState extends ShopStates {}

class ShopChangeBottomState extends ShopStates {}
class ShopChangeLanguageState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {
  final String error;
  ShopErrorHomeState(this.error);
}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeSuccessFavoritesState extends ShopStates {
  PostToFavoritesModel? favoritesModel;
  ShopChangeSuccessFavoritesState(this.favoritesModel);
}

class ShopChangeErrorFavoritesState extends ShopStates {
  final String error;
  ShopChangeErrorFavoritesState(this.error);
}

class ShopChangeCartState extends ShopStates {}

class ShopChangeSuccessCartState extends ShopStates {
  PostToCartModel? cartModel;
  ShopChangeSuccessCartState(this.cartModel);
}

class ShopChangeErrorCartState extends ShopStates {
  final String error;
  ShopChangeErrorCartState(this.error);
}


class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {
  final String error;
  ShopErrorFavoritesState(this.error);
}

class ShopLoadingUserState extends ShopStates {}

class ShopSuccessUserState extends ShopStates {}

class ShopErrorUserState extends ShopStates {
  final String error;
  ShopErrorUserState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  ShopSuccessUpdateUserState();
}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;
  ShopErrorUpdateUserState(this.error);
}

class ShopLoadingLogoutState extends ShopStates {}

class ShopSuccessLogoutState extends ShopStates {}

class ShopErrorLogoutState extends ShopStates {
  final String error;
  ShopErrorLogoutState(this.error);
}

class ShopLoadingChangePasswordState extends ShopStates {}

class ShopSuccessChangePasswordState extends ShopStates {
}

class ShopErrorChangePasswordState extends ShopStates {
  final String error;
  ShopErrorChangePasswordState(this.error);
}


class ShopLoadingGetCartsState extends ShopStates {}

class ShopSuccessGetCartsState extends ShopStates {
}

class ShopErrorGetCartsState extends ShopStates {
  final String error;
  ShopErrorGetCartsState(this.error);
}

class ShopChangeCurrentIndexState extends ShopStates {
}