// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/register/register_cubit/shop_register_cubit.dart';
import 'package:shop_app/modules/register/register_cubit/shop_register_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopSuccessesRegisterState) {
            if (state.registerModel.status) {
              token = '${state.registerModel.data?.token}';
              CacheHelper.saveData(
                  key: 'token', value: state.registerModel.data?.token)
                  .then((value) {
                showToast(
                  message: state.registerModel.message!,
                  state: ToastState.success,
                );
                navigateAndFinish(context,MyApp(ShopHomeLayout()));
              });
            }
            else {
              showToast(
                message: state.registerModel.message!,
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    ShopRegisterCubit.get(context).changeLanguage();
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
                SizedBox(width: 20.0,),

              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFromField(
                          context: context,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          labelText: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          labelText: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                          context: context,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          labelText: 'Phone',
                          prefix: Icons.phone_android,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                            context: context,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Password';
                              }
                              return null;
                            },
                            labelText: 'Password',
                            prefix: Icons.email_outlined,
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            suffix: ShopRegisterCubit.get(context).isPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            suffixOnPressed: () {
                              ShopRegisterCubit.get(context).changeVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoadingRegisterState,
                          builder: (context) => defaultButton(
                            context: context,
                            text: 'Register',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
