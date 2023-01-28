// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/models/login_,model.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/profile/edit_profile.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return profile(ShopCubit.get(context).userModel!.data!, context,state);
      },
    );
  }
}

Widget profile(UserData model, context,state) => Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 30.0,
        right: 30.0,
        bottom: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(state is ShopLoadingUserState)
              LinearProgressIndicator(),
            SizedBox(height: 20.0,),
            AppBar(
              backgroundColor: Colors.blueGrey[700],
              elevation: 40,
              toolbarHeight: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage('${model.image}')),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7.0,),
                      Text(
                        '${model.name}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ID:${model.id}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0,),
                                side: BorderSide(color: secondaryColor),
                              ),),
                            ),
                            onPressed: () {
                              navigateTo(context, EditProfile());
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: defaultColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'phone',
              style: TextStyle(
                fontSize: 14.0,
                color: secondaryColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: secondaryColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${model.phone}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Icon(
                    Icons.phone,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'email',
              style: TextStyle(
                fontSize: 14.0,
                color: secondaryColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: secondaryColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${model.email}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: secondaryColor,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Icon(
                    Icons.email_outlined,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: secondaryColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${model.points}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  Text(
                    'points',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: secondaryColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${model.credit}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Text(
                    'credit',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            ElevatedButton(
              onPressed: (){
                ShopCubit.get(context).logOut();
                CacheHelper.removeData(key: 'token').then((value){
                  if(value){
                    navigateAndFinish(context, ShopLoginScreen());
                  }
                });


              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Logout'),
                  SizedBox(width: 5.0),
                  Icon(Icons.logout,),
                ],
              ),
            ),
          ],
        ),
      ),
    );


/*

Center(
child: Text(
'Settings Screen',
)),
IconButton(
onPressed: () {
CacheHelper.removeData(key: 'onBoarding').then((value) {
if (value) {
CacheHelper.removeData(key: 'token').then((value) {
if (value) {
print("View on boarding new ");
navigateAndFinish(context, OnBoardingScreen());
}
});
}
});
},
icon: Icon(Icons.star),
),
IconButton(
onPressed: () {
CacheHelper.removeData(key: 'token').then((value) {
if (value) {
navigateAndFinish(context, ShopLoginScreen());
}
});
},
icon: Icon(Icons.logout),
),
IconButton(
onPressed: () {},
icon: Icon(Icons.man),
),*/
