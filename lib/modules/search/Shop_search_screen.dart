// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/shop_search_cubit.dart';
import 'package:shop_app/modules/search/cubit/shop_search_state.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopSearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFromField(
                    context: context,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the Text';
                      }
                      return null;
                    },
                    labelText: 'Search',
                    onSubmit: (value) {
                      ShopSearchCubit.get(context).productSearch(searchController.text);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopLoadingSearchState)
                    LinearProgressIndicator(),
                  if( ShopSearchCubit.get(context).searchModel!=null)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildProductItem(
                          ShopSearchCubit.get(context).searchModel!.data!.data[index], context,isSearch: true),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                      ),
                      itemCount: ShopSearchCubit.get(context).searchModel!.data!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
