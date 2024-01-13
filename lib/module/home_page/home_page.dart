import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoshua_ui_test/widget/categorybar.dart';

import '../../helper/custom_size.dart';
import '../../util/NoOverScrollGlow.dart';
import '../../widget/navigators.dart';
import '../../widget/shop_item.dart';
import '../cart_page/cart_page.dart';
import '../product_detail_page/product_detail_page.dart';
import 'bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbar(),
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: SafeArea(
          child: Body()
        ),
      ),
      floatingActionButton: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  AppBar? appbar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 30,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("TestingUI", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
          Row(
            children: [
              InkWell(
                  onTap: (){

                  },
                  child: Icon(Icons.search, size: 25, color: Colors.black,)),
              SizedBox(width: 5,),
            ],
          )
        ],
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
    );
  }

  Widget Body(){
    return ScrollConfiguration(
      behavior: NoOverscrollBehavior(),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Halo user", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
            Text("What's you are looking for?", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35),),
            SizedBox(height: 10,),
            CategoryBar(),
            SizedBox(height: 20,),
            ShopItemList()
          ],
        ),
      ),
    );
  }

  Widget CategoryBar(){
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      minVerticalPadding: 0,
      minLeadingWidth: 0,
      dense: true,
      subtitle: SizedBox(
        height: 45,
        width: Cmdof().W(context),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return CategoryBarItem(
              currentIndex: currentIndex,
                index: index,
                title: "Anime Koi Koi",
                onTap: () {
                  // Navigators.push(context, const TopicDetailPage());
                  setState(() {
                    currentIndex = index;
                  });
                }
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 10);
          },
        ),
      ),
    );
  }

  Widget ShopItemList(){
    return Container(
      height: Cmdof().H(context),
      width: Cmdof().W(context),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        itemCount: 9,
        itemBuilder: (context, index) {
          return ShopItem(
            imgUrl: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            productName: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            productPrice: "USD 109.95",
            rating: 3.9,
            review: 120,
            onTap: (){
              Navigators.push(context,
                  ProductDetailPage(imgUrl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                  productName: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                  price: 109.95,
                  review: 120,
                  rating: 3.9,
                  desc: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                  )
              );
            },
          );
        },
      ),
    );
  }

  Widget BottomNavBar(){
    return InkWell(
      onTap: (){
        Navigators.push(context, CartPage());
      },
      child: Container(
        width: Cmdof().W(context),
        height: Cmdof().custH(0.07, context),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 25),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, size: 25, color: Colors.white,),
              Text("cart", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
