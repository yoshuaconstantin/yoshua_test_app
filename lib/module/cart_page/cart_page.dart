import 'package:flutter/material.dart';
import 'package:yoshua_ui_test/util/NoOverScrollGlow.dart';

import '../../helper/custom_size.dart';
import '../../widget/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int totalCart = 0 ;
  int totalItem = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: appbar(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar? appbar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 30,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    );
  }

  Widget Body(){
    return ScrollConfiguration(
        behavior: NoOverscrollBehavior(),
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.size10),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              crossAxisCount: 4,
              childAspectRatio: 0.375
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return CartItem(

            );
          },
        ),
    ),);

  }

  Widget BottomNavBar(){
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: Cmdof().W(context),
        height: Cmdof().custH(0.09, context),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total: USD "+totalCart.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),),
                    Text(totalItem.toString()+" Item", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white,)
              ],
            ),
          ),
        ),
      ),
    );
  }

}
