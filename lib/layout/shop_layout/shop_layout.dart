// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/carts/cards_screen.dart';
import 'package:shop_app/modules/search/Shop_search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopHomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
              style: TextStyle(
                color: secondaryColor[900],
              ),
            ),
            actions: [
              IconButton(
                iconSize: 40.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  navigateTo(context, CartsScreen());
                },
                icon: Stack(
                  fit: StackFit.expand,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: secondaryColor[600],
                      size: 30.0,

                    ),
                    if( ShopCubit.get(context).cartsModel!=null)
                    Positioned(
                      top: 5,
                      left: 2,
                      child: CircleAvatar(
                        radius: 9.0,
                        backgroundColor: defaultColor,
                        child: Text(ShopCubit.get(context).cartsModel!.data!.cartItems.length>9?'+9'
                          :'${ ShopCubit.get(context).cartsModel!.data!.cartItems.length}' ,
                          style: TextStyle(
                            color: Colors.white                                                                                    ,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeLanguage();
                  CacheHelper.saveData(key: 'language', value: language).then((value) {
                    navigateTo(context, MyApp(ShopHomeLayout()));

                  });
                },
                icon: CircleAvatar(
                  radius: 16.0,
                  backgroundColor: secondaryColor,
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Text(
                      language.toUpperCase(),
                      style: TextStyle(
                        color: defaultColor,
                        fontWeight: FontWeight.w500,

                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, ShopSearchScreen());
                },
                icon: Icon(
                  Icons.search,
                  color: secondaryColor[900],
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
