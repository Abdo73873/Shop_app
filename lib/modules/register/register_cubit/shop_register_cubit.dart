import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_,model.dart';
import 'package:shop_app/modules/register/register_cubit/shop_register_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

 class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
   ShopRegisterCubit():super(ShopInitializeRegisterState());
   static ShopRegisterCubit get(context)=>BlocProvider.of(context);
   bool isPassword=true;
   void changeVisibility(){
     isPassword=!isPassword;
     emit(ShopChangeVisibilityState());
   }

  late ShopLoginModel registerModel ;

   void userRegister({
   required String email,
   required String name,
   required String password,
   required String phone,
    String? image,
     Map<String,dynamic>? query,
 }){
     emit(ShopLoadingRegisterState());
     DioHelper.postData(
         urlPath: REGISTER,
         data: {
           'name':name,
           'phone':phone,
           'email':email,
           'password':password,
           'image':image,
         },
       language:language,
       query: query,
     ).then((value) {
       registerModel=ShopLoginModel.fromJson(value.data);
       emit(ShopSuccessesRegisterState(registerModel));
     }).catchError((error){
       emit(ShopErrorRegisterState(error));
     });
   }

   void changeLanguage(){
     if(language=='ar'){
       language='en';
     } else {language='ar';}
     emit(ShopChangeLanguageState());
   }

 }