
abstract class ShopSearchStates{}
class ShopInitializeSearchState extends ShopSearchStates{}
class ShopLoadingSearchState extends ShopSearchStates{}
class ShopSuccessesSearchState extends ShopSearchStates{}
class ShopErrorSearchState extends ShopSearchStates{
  final String error;
  ShopErrorSearchState(this.error);

}