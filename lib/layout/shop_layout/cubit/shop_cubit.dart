import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/fevorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_,model.dart';
import 'package:shop_app/models/post_to_favorites_and_carts_model.dart';
import 'package:shop_app/modules/categories/cateogties_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/profile/profile_Screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitializeState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];
  void changeBottomScreen(index) {
    currentIndex = index;
    emit(ShopChangeBottomState());
  }

  void changeLanguage(){
    if(language=='ar'){
      language='en';
    } else {language='ar';}
    emit(ShopChangeLanguageState());
}

  Map<int, bool> favorites ={};
   Map<int,bool> inCart={};


  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
      language: language,
      urlPath: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.intFavorites,
        });
      });
      homeModel!.data.products.forEach((element) {
        inCart.addAll({
          element.id: element.inCart,
        });
      });

      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesModel() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      urlPath: CATEGORIES,
      language: language,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error));
    });
  }

  PostToFavoritesModel? postToFavorites;
  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      urlPath: FAVORITES,
      language: language,
      token: token,
      data: {
        "product_id": productId,
      },
    ).then((value) {
      postToFavorites = PostToFavoritesModel.fromJson(value.data);
      if (postToFavorites?.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesModel();
      }
      emit(ShopChangeSuccessFavoritesState(postToFavorites));
    }).catchError((error) {
      if (postToFavorites == null || postToFavorites!.status == false) {
        favorites[productId] = !favorites[productId]!;
      }
      emit(ShopChangeErrorFavoritesState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesModel() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
      urlPath: FAVORITES,
      language: language,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      emit(ShopErrorFavoritesState(error.toString()));
    });
  }

  ShopLoginModel? userModel;
  void getUser() {
    emit(ShopLoadingUserState());
    DioHelper.getData(
      urlPath: PROFILE,
      language: language,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserState());
    }).catchError((error) {
      emit(ShopErrorUserState(error.toString()));
    });
  }

  ShopLoginModel? testUpdateProfile;
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      urlPath: UPDATAPROFILE,
      language: language,
      token: token,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "image": ''
      },
    ).then((value) {
      testUpdateProfile = ShopLoginModel.fromJson(value.data);
      if (testUpdateProfile?.status == true) {
        getUser();
        showToast(message:testUpdateProfile!.message! , state: ToastState.success);
      }
      emit(ShopSuccessUpdateUserState());
    }).catchError((error) {
      emit(ShopErrorUpdateUserState(error.toString()));
    });
  }


  void logOut( ) {
    emit(ShopLoadingLogoutState());
    DioHelper.postData(
      urlPath: LOGOUT,
      language: language,
      token: token,
      data: {
        "fcm_token": "SomeFcmToken"
      },
    ).then((value) {
      showToast(message:value.data["message"].toString(), state: ToastState.success);

      emit(ShopSuccessLogoutState());
    }).catchError((error) {
      emit(ShopErrorLogoutState(error.toString()));
    });
  }


  void changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
}){
    emit(ShopLoadingChangePasswordState());
    DioHelper.postData(
      urlPath: CHANGEPASSWORD,
      language: language,
      token: token,
      data: {
        "current_password": currentPassword,
        "new_password": newPassword,
      },
    ).then((value) {
      if(value.data["status"]){
        showToast(message:value.data["message"] , state: ToastState.success);
        Navigator.pop(context);
        emit(ShopSuccessChangePasswordState());
      }
      else {
        showToast(message:value.data["message"] , state: ToastState.error);
        emit(ShopSuccessChangePasswordState());

      }
    }).catchError((error) {
      emit(ShopErrorChangePasswordState(error.toString()));
    });


  }


  void postCart(int productId){
    emit(ShopLoadingGetCartsState());
    DioHelper.postData(
        urlPath: CARTS,
        language: language,
        token: token,
        data: {
          'product_id':productId,
        }).then((value) {
      emit(ShopSuccessGetCartsState());
    }).catchError((error) {
      emit(ShopErrorGetCartsState(error.toString()));
    });
  }

  PostToCartModel? postToCartModel;
  void changeCarts(int productId) {
    inCart[productId] = !inCart[productId]!;
    emit(ShopChangeCartState());
    DioHelper.postData(
      urlPath: CARTS,
      language: language,
      token: token,
      data: {
        "product_id": productId,
      },
    ).then((value) {
      postToCartModel = PostToCartModel.fromJson(value.data);
      if (postToCartModel?.status == false) {
        inCart[productId] = !inCart[productId]!;
      } else {
        getCart();
      }
      emit(ShopChangeSuccessCartState(postToCartModel));
    }).catchError((error) {
      if (postToCartModel == null || postToCartModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      }
      emit(ShopChangeErrorFavoritesState(error.toString()));
    });
  }




  CartsModel? cartsModel;
  void getCart(){
    emit(ShopLoadingGetCartsState());
    DioHelper.getData(
      urlPath: CARTS,
      language: language,
      token: token,
    ).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      emit(ShopSuccessGetCartsState());
    }).catchError((error) {
      emit(ShopErrorGetCartsState(error.toString()));
    });
  }
   int currentImage=0;
  void changeCurrentIndex(int index){
    currentImage=index;
    emit(ShopChangeCurrentIndexState());
  }

}
