// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/products/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';


class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeSuccessFavoritesState) {
          if (state.favoritesModel!.status == false) {
            showToast(
              message: state.favoritesModel!.message ?? '',
              state: ToastState.error,
            );
          }
          if (state.favoritesModel!.status == true) {
            showToast(
              message: state.favoritesModel!.message ?? '',
              state: ToastState.success,
            );
          }
        }
        if (state is ShopChangeSuccessCartState) {
          if (state.cartModel!.status == false) {
            showToast(
              message: state.cartModel!.message ?? '',
              state: ToastState.error,
            );
          }
          if (state.cartModel!.status == true) {
            showToast(
              message: state.cartModel!.message ?? '',
              state: ToastState.success,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model, CategoriesModel categoriesModel, context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners.map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ).toList(),
              options: CarouselOptions(
                autoPlay: true,
                scrollDirection: Axis.horizontal,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                viewportFraction: 1,
                initialPage: 0,
                height: 200.0,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollPhysics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATEGORIES',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Dreams",
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategories(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'NEW PRODUCTS',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Dreams",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.75,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );


  Widget buildGridProduct(ProductsModel model, context) => InkWell(
    onTap: (){
      navigateTo(context, ProductDetails(
        id: model.id,
        name: model.name,
        image: model.image,
        price: model.price,
        oldPrice: model.oldPrice,
        discount: model.discount,
        description: model.description,
        inCart: ShopCubit.get(context).inCart[model.id],
        images: model.images,

      ));
    },
    child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: double.infinity,
                    height: 200.0,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.red,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  if (model.discount != 0)
                    Positioned(
                      top: 5.0,
                      left: 5.0,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: defaultColor,
                        child: Text(
                          '${model.discount}%\nSale',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 100.0,
                  child: Column(
                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()} LE',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()} LE',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.0,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeCarts(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:
                              ShopCubit.get(context).inCart[model.id]!
                                  ? Colors.green
                                  : Colors.grey[400],
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                            iconSize: 16.0,
                          ),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorite(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? defaultColor
                                  : Colors.grey[400],
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                            iconSize: 16.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
  );

  Widget buildCategories(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100.0,
            width: 100.0,
          ),
          Container(
            color: defaultColor.withOpacity(0.9),
            width: 100.0,
            child: Text(
              model.name,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
