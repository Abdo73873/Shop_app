import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_,model.dart';
import 'package:shop_app/modules/login/cubit/shop_login_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


 class ShopLoginCubit extends Cubit<ShopLoginStates>{
   ShopLoginCubit():super(ShopInitializeLoginState());
   static ShopLoginCubit get(context)=>BlocProvider.of(context);
   bool isPassword=true;
   void changeVisibility(){
     isPassword=!isPassword;
     emit(ShopChangeVisibilityState());
   }

  late ShopLoginModel loginModel ;

   void userLogin({
   required String email,
   required String password,
     Map<String,dynamic>? query,
 }){
     emit(ShopLoadingLoginState());
     DioHelper.postData(
         urlPath: LOGIN,
       language:language,
       query: query,
       token: token,
         data: {
           'email':email,
           'password':password,
         },
     ).then((value) {
       loginModel=ShopLoginModel.fromJson(value.data);
       emit(ShopSuccessesLoginState(loginModel));
     }).catchError((error){
       emit(ShopErrorLoginState(error));
     });
   }

   void changeLanguage(){
     if(language=='ar'){
       language='en';
     } else {language='ar';}
     emit(ShopChangeLanguageState());
   }

 }