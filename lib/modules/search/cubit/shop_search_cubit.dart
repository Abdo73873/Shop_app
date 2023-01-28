import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/shop_search_state.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit():super(ShopInitializeSearchState());
  static ShopSearchCubit get(context)=>BlocProvider.of(context);

   SearchModel? searchModel;
  void productSearch(String text){
    emit(ShopLoadingSearchState());
    DioHelper.postData(
      urlPath: SEARCH,
      data: {
        'text':text,
      },
      language:language,
      token: token,
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(ShopSuccessesSearchState());
    }).catchError((error){
      emit(ShopErrorSearchState(error));
    });
  }

}