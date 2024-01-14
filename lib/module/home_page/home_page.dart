import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoshua_ui_test/widget/categorybar.dart';

import '../../api/endpoint/product/get_product_response.dart';
import '../../helper/custom_size.dart';
import '../../util/NoOverScrollGlow.dart';
import '../../widget/FlushBar.dart';
import '../../widget/navigators.dart';
import '../../widget/shop_item.dart';
import '../cart_page/cart_page.dart';
import '../product_detail_page/product_detail_page.dart';
import '../search_page/search_page.dart';
import 'bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = false;
  int currentIndex = 0;

  List<dynamic> categoryData = [];
  List<ProductResponse> productsData = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:appbar(),
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is onGetCategorySuccess){
            setState(() {
              categoryData.add("All");
              categoryData.addAll(state.data);
            });

          } else if (state is onGetCategoryFailed){
            FlushBarWidget.showFailure(state.message)
                .show(context);
          } else if (state is onGetProductsSuccess){
            setState(() {
              productsData.clear();
              productsData = state.data;
            });
          } else if (state is onGetProductsLoading){
            setState(() {
              isLoading = true;
            });
          } else if (state is onGetProductsFailed){
            FlushBarWidget.showFailure(state.message)
                .show(context);
          } else if (state is onGetProductsFinished){
            setState(() {
              isLoading = false;
            });
          }
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

  @override
  void initState() {
    // TODO: implement initState
    context.read<HomePageBloc>().add(GetHomeCategory());
    context.read<HomePageBloc>().add(GetHomeProduct());
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
                    Navigators.push(context, SearchPage());
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
    );
  }

  Widget CategoryBar(){
    return categoryData.isEmpty ? Text("-")
        :
    ListTile(
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
          itemCount: categoryData.length,
          itemBuilder: (context, index) {
            return CategoryBarItem(
              currentIndex: currentIndex,
                index: index,
                title: categoryData[index],
                onTap: () {
                  // Navigators.push(context, const TopicDetailPage());
                  setState(() {
                    currentIndex = index;
                    if(categoryData[index].toString() == "All"){
                      context.read<HomePageBloc>().add(GetHomeProduct());
                    }else{
                      context.read<HomePageBloc>().add(GetCategoryProducts(categories: categoryData[index].toString()));
                    }
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
    return productsData.isEmpty ?
    SizedBox() :
    Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        itemCount: productsData.length,
        itemBuilder: (context, index) {
          ProductResponse data = productsData[index];
          return ShopItem(
            imgUrl: data.image,
            productName: data.title,
            productPrice: data.price,
            rating: data.rating!.rate,
            review: data.rating!.count,
            onTap: (){
              Navigators.push(context,
                  ProductDetailPage(imgUrl: data.image,
                  productName: data.title,
                  price: data.price,
                  review: data.rating!.count,
                  rating: data.rating!.rate,
                  desc: data.description,
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
