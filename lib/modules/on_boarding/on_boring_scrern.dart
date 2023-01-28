// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardModel{
  final String image;
  final String title;
  final String body;
  BoardModel({
    required this.image,
    required this.title,
    required this.body,
});

}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
List<BoardModel> boarding=[
  BoardModel(
      image: 'assets/images/board1.jpg',
      title: 'Purchase Your Items Online',
      body: 'Many products are available for you',
  ),
  BoardModel(
    image: 'assets/images/board2.png',
    title: 'Put In The Cart',
    body: 'Discount on all products, best offers up to 90%',
  ),
  BoardModel(
    image: 'assets/images/board3.jpg',
    title: 'Delivery',
    body: 'Receive your product immediately',
  ),

];
PageController boardController =PageController();
bool isLast=false;

void submit(){
  CacheHelper.saveData(key: 'onBoarding', value: false,).then((value){
    navigateAndFinish(context,ShopLoginScreen());
  });

}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          defaultText(
            text: 'SKIP',
            onPressed: submit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller:boardController ,
                  itemBuilder: (context,index)=>boardItem(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height:30.0 ,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotWidth: 10,
                    dotHeight: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.linear,
                      );
                    }

                  },
                  child: Icon(
                  Icons.arrow_forward_ios,

                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boardItem(BoardModel model)=>Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        SizedBox(height: 40.0,),
        Text(model.title,
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Bassant',
          ),
        ),
        SizedBox(height: 30.0,),

        Text(model.body,
          style: TextStyle(
            fontSize: 18.0,
            color: secondaryColor,
            fontFamily: 'Bassant',
          ),
        ),

        //PageView.builder(itemBuilder: (context,index)=>),
      ],
    ),
  );
}
