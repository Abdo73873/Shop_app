// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/modules/products/product_details.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  double radius = 10.0,
  required BuildContext context,
  Color? background,
  bool isUppercase = true,
  required String text,
  required Function() onPressed,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFromField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType keyboardType,
  Function(String)? onSubmit,
  Function(String)? onChange,
  required String? Function(String?) validator,
  required String labelText,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixOnPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        border: OutlineInputBorder(),
        prefixIcon: prefix != null
            ? Icon(
                prefix,
                color: Colors.deepOrange[300],
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                  color: Colors.deepOrange[300],
                ),
                onPressed: suffixOnPressed,
                color: Theme.of(context).iconTheme.color,
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.deepOrangeAccent,
        )),
      ),
      style: Theme.of(context).textTheme.button,
      textDirection: TextDirection.ltr,
    );

Widget defaultText({
  required String text,
  required Function()? onPressed,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );


void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
    (route) => false);

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildProductItem(
  model,
  context, {
  bool isSearch = false,
}) => InkWell(
  onTap: (){
    navigateTo(context, ProductDetails(
        id: model.id,
        name: model.name,
      isSearch: isSearch,
      price: model.price,
      oldPrice:model.oldPrice ,
      description: model.description,
      discount: model.discount,
      image: model.image,

    ),);
  },
  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 130.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: 130.0,
                    height: 130.0,
                  ),
                  if (!isSearch)
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
                  if (!isSearch)
                    if (model.discount != 0)
                      Positioned(
                        top: 5.0,
                        left: 5.0,
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: defaultColor,
                          child: Text(
                            '50%\nSale',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.1,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${model.price} LE',
                          style: TextStyle(
                            color: defaultColor,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (!isSearch)
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice} LE',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!isSearch)
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
                        if (!isSearch)
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorite(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: ShopCubit.get(context)
                                  .favorites!
                                  .containsKey(model.id)
                                  ? ShopCubit.get(context).favorites![model.id]!
                                  ? Colors.red
                                  : Colors.grey[400]
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
            ],
          ),
        ),
      ),
);

Widget separated()=>Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 20.0,
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[300],
  ),
);