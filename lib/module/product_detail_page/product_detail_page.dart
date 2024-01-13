import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yoshua_ui_test/helper/custom_size.dart';

class ProductDetailPage extends StatefulWidget {
  final String imgUrl;
  final double price;
  final String productName;
  final double rating;
  final int review;
  final String desc;

  const ProductDetailPage({super.key, required this.desc, required this.imgUrl, required this.price, required this.productName, required this.rating, required this.review});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Body(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar? appbar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 30,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: (){

              },
              child: Icon(Icons.shopping_cart, size: 25, color: Colors.black,))
        ],
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    );
  }

  Widget Body(){
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: Cmdof().W(context),
                  height: Cmdof().custH(0.3, context),
                  child: Image.network(widget.imgUrl)
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price: USD "+widget.price.toString(),style: TextStyle(fontSize: 17, color: Colors.blue, fontWeight: FontWeight.w600),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blueGrey, width: 1)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 20,),
                            Text(widget.rating.toString(), style: TextStyle( fontSize: 14),),
                            SizedBox(width: 10,),
                            Text(widget.review.toString(), style: TextStyle( fontSize: 14),),
                            Text(" reviews", style: TextStyle( fontSize: 14),),

                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(widget.productName ,style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),),
              SizedBox(height: 25,),
              Text("Description" ,style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),),
              SizedBox(height: 5,),
              Text(widget.desc ,style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),),
            ],
          ),
        )
    );
  }

  Widget BottomNavBar(){
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: Cmdof().W(context),
        height: Cmdof().custH(0.07, context),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: Text("Add to cart", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),),
        ),
      ),
    );
  }

}
