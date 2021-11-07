import 'package:e_commerce_app/app_localization.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/models/carts_model.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/components/defualt_rectangle_button.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/components/show_message.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class CheckoutScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  List<String> cities = ['Assyt', 'Cairo', 'Aswan', 'Sohag', ''];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is AddAddressErrorState)
          showMessageBox(message: state.message!, context: context);
        if (state is AddOrderErrorState)
          showMessageBox(message: state.message!, context: context);
        if (state is AddOrderSuccessState)
          showToast(msg: state.message!, backColor: Colors.green);
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var local = AppLocalizations.of(context)!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: defualtAppBar(
              context: context,
              titleWidget: Text(
                local.translate('Checkout')!,
                style: titleTextStyle,
              ),
              onLeadPress: () {
                Navigator.pop(context);
              }),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                cubit.cartModel!.data!.cartsItems.length > 0,
            widgetBuilder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        local.translate('Billing details')!,
                        style: mainTitleTextStyle,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // name text field
                          InputTextField(
                            title: 'Name',
                            controller: cubit.nameController,
                            validateText: 'Name is required',
                          ),
                          // city drobDown text field
                          Row(
                            children: [
                              Text(local.translate('City')!),
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.red,
                                size: 10,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: DropdownButtonFormField(
                              items: cities.map(
                                (String city) {
                                  return DropdownMenuItem(
                                    child: Text(city),
                                    value: city,
                                  );
                                },
                              ).toList(),
                              value: cubit.selectedCity,
                              onChanged: (String? city) {
                                cubit.changeCurrentCity(city!);
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 16, 10, 16),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: .5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: .5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // region text field
                          InputTextField(
                            title: 'Region',
                            controller: cubit.regionController,
                            validateText: 'Region is required',
                          ),
                          // details text field
                          InputTextField(
                            title: 'Details',
                            controller: cubit.detailsController,
                            validateText: 'Details is required',
                          ),
                          // order notes
                          InputTextField(
                            title: 'Order Notes',
                            controller: cubit.notesController,
                            isOptional: true,
                            isNotes: true,
                          ),
                        ],
                      ),
                    ),
                    // your order text
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        local.translate('Your Order')!,
                        style: mainTitleTextStyle,
                      ),
                    ),
                    reusableContainer(
                      'Product',
                      local.translate('Subtotal')!,
                      context,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildBillItem(
                          cubit.cartModel!.data!.cartsItems[index], index),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: cubit.cartModel!.data!.cartsItems.length,
                    ),
                    reusableContainer('SubTotal',
                        '${cubit.cartModel!.data!.subTotal}\$', context),
                    reusableContainer(
                      'Total',
                      '${cubit.cartModel!.data!.total}\$',
                      context,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 120,
                      child: Column(
                        children: [
                          RadioListTile<Payments>(
                            title: Text(
                              local.translate('Cache on delivery')!,
                              style: TextStyle(fontSize: 18),
                            ),
                            value: Payments.Cache,
                            groupValue: cubit.paymentWay,
                            onChanged: (Payments? value) {
                              cubit.changePaymentWay(value!);
                            },
                          ),
                          RadioListTile<Payments>(
                            title: Text(
                              local.translate('Online Payments')!,
                              style: TextStyle(fontSize: 18),
                            ),
                            value: Payments.Online,
                            groupValue: cubit.paymentWay,
                            onChanged: (Payments? value) {
                              cubit.changePaymentWay(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    if (state is! AddAddressLoadingState)
                      DefualtRectangleButton(
                          onpress: () {
                            if (formKey.currentState!.validate()) {
                              cubit.addAddress();
                            }
                          },
                          title: 'Add Order'),
                    if (state is AddAddressLoadingState)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            fallbackBuilder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefualtRectangleButton(
                  title: 'Return To Home',
                  onpress: () {
                    cubit.changeCurrentIndex(0);
                    navigateTo(context: context, nextScreen: MainLayout());
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// text field
class InputTextField extends StatelessWidget {
  String title;
  String? validateText;
  TextEditingController controller;
  bool isNotes;
  bool isOptional;
  InputTextField({
    required this.title,
    required this.controller,
    this.isOptional = false,
    this.isNotes = false,
    this.validateText,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(AppLocalizations.of(context)!.translate(title)!),
            !isOptional
                ? Icon(
                    Icons.star_rate_rounded,
                    color: Colors.red,
                    size: 10,
                  )
                : Text(AppLocalizations.of(context)!.translate('(optional)')!),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: TextFormField(
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
              hintText: isNotes
                  ? 'Notes about your order, e.g special notes for delivery'
                  : null,
              contentPadding: isNotes
                  ? EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    )
                  : EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: .5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: .5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey[300]!,
                ),
              ),
            ),
            validator: !isOptional
                ? (String? value) {
                    if (value!.isEmpty) return validateText;
                    return null;
                  }
                : null,
          ),
        ),
      ],
    );
  }
}

// product in bill
Widget buildBillItem(CartItem item, int index) {
  return Container(
    height: 70,
    width: double.infinity,
    color: index % 2 == 0 ? Colors.grey[50] : Colors.grey[100],
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Text('x${item.quantity}'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 30),
            child: Text('${item.product.price}\$'),
          ),
        ),
      ],
    ),
  );
}

// reusable container for bill
Widget reusableContainer(String text1, String text2, BuildContext context) {
  return Container(
    height: 70,
    width: double.infinity,
    color: Colors.grey[300],
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Text(
              AppLocalizations.of(context)!.translate(text1)!,
              style: priceTextStyle,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: Text(
              text2,
              style: priceTextStyle,
            ),
          ),
        ),
      ],
    ),
  );
}
