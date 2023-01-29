// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ProductDetails  extends StatefulWidget {

  int? id;
  String? image;
  String? name;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? description;
   bool isSearch;
   bool? inCart;
   List<String>? images=[];
  ProductDetails({
    this.id,
    this.name,
    this.image,
    this.price,
    this.oldPrice,
    this.discount,
    this.description,
    this.isSearch=false,
    this.inCart,
    this.images,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {





  var scaffoldKey=GlobalKey<ScaffoldState>();
    int currentImage=0;
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          key:scaffoldKey ,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    if(widget.images!.isNotEmpty)
                    CarouselSlider(
                      items:List.generate(
                          widget.images!.length,
                              (index) => Image(image: NetworkImage(widget.images![index]),),
                      ) ,
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                        initialPage: 0,
                        height: 300.0,
                        enableInfiniteScroll: false,
                        scrollPhysics: BouncingScrollPhysics(),
                        enlargeCenterPage: true,
                        onPageChanged: (index,reason){
                          setState(() {
                            currentImage=index;
                          });
                        },
                      ),
                    ),
                    if(widget.images!.isNotEmpty)
                      AnimatedSmoothIndicator(
                        activeIndex:currentImage,
                      count: widget.images!.length,
                      effect:const JumpingDotEffect(
                        dotHeight: 13,
                        dotWidth: 13,
                        jumpScale: .7,
                        verticalOffset: 20,
                        activeDotColor: defaultColor,
                        dotColor: secondaryColor,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    if(widget.images!.isEmpty)
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(image: NetworkImage('${widget.image}'),),
                        SizedBox(height: 10.0,),
                        if(!widget.isSearch)
                          if (widget.discount != 0)
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
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        if(!widget.isSearch)
                          if (widget.discount != 0)
                          Positioned(
                            top: 5.0,
                            left: 5.0,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: defaultColor,
                              child: Text(
                                '${widget.discount}%\nSale',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            '${widget.name}',
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.price.round()} LE',
                                style: TextStyle(
                                  color: defaultColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              if(!widget.isSearch)
                                if (widget.discount != 0)
                                  Text(
                                  '${widget.oldPrice.round()} LE',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Spacer(),
                              if(!widget.isSearch)
                              IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).changeFavorite(widget.id!);
                                },
                                icon: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor:
                                  ShopCubit.get(context).favorites![widget.id]!
                                      ? Colors.red
                                      : Colors.grey[400],
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                                iconSize: 20.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${widget.description}',
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.4,

                      ),
                      textDirection:language=='ar'?TextDirection.rtl:TextDirection.ltr,
                    ),

                  ],
                ),
              ),
            ),
          ),
          bottomSheet:Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10.0,
              bottom: 20.0,
              start: 30.0,
              end: 30.0,
            ),
            child: Row(
              children: [
                Text(
                  '${widget.price.round()} LE',
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      ShopCubit.get(context).changeCarts(widget.id!);
                    });
                  },
                  child: Text(
                      ShopCubit.get(context).inCart[widget.id]!?
                           'Remove from Cart':'Add to cart',
                  ),
                ),
              ],
            ),
          ) ,
                );

  }
}

