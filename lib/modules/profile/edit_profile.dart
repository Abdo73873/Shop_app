// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';


class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController nameController = TextEditingController();
        TextEditingController emailController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        TextEditingController oldPasswordController = TextEditingController();
        TextEditingController newPasswordController = TextEditingController();
        nameController.text = ShopCubit.get(context).userModel!.data!.name!;
        phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;
        emailController.text = ShopCubit.get(context).userModel!.data!.email!;
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    SizedBox(height: 20.0,),
                    if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                    SizedBox(height: 30.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultFromField(
                          prefix: Icons.person,
                          context: context,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                          labelText: 'Name',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                          prefix: Icons.phone,
                            context: context,
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Phone';
                              }
                              return null;
                            },
                            labelText: 'phone'),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                            prefix: Icons.email,
                            context: context,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Email';
                              }
                              return null;
                            },
                            labelText: 'email'),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultText(
                            text: 'Change Password',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  elevation: 20.0,
                                  clipBehavior:Clip.hardEdge ,
                                  title: Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, icon: Icon(Icons.arrow_back_ios),),
                                      Text('Change Password',
                                      style: TextStyle(
                                        color: defaultColor,
                                      ),),
                                    ],
                                  ),
                                  content: SingleChildScrollView(
                                    child: Form(
                                      key: passwordKey,
                                      child: Column(
                                        children: [
                                          defaultFromField(
                                              context: context,
                                              controller: oldPasswordController,
                                              keyboardType:
                                              TextInputType.visiblePassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter your password';
                                                }
                                                return null;
                                              },
                                              labelText: 'Current password'),
                                          SizedBox(height: 20.0,),
                                          defaultFromField(
                                              context: context,
                                              controller: newPasswordController,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter your password';
                                                }
                                                return null;
                                              },
                                              labelText: 'New password'),
                                          SizedBox(height: 40.0,),
                                          ElevatedButton(
                                            onPressed: () {
                                              if(passwordKey.currentState!.validate()){
                                                ShopCubit.get(context).changePassword(
                                                  currentPassword: oldPasswordController.text,
                                                  newPassword: newPasswordController.text,
                                                  context: context,
                                                );
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.save_alt),
                                                Text('Save'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                    SizedBox(height: 50.0,),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                          Navigator.pop(context);

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save_alt),
                          Text('Save'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
