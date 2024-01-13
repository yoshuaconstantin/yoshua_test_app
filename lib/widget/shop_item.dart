import 'package:flutter/material.dart';
import 'package:yoshua_ui_test/helper/custom_size.dart';

class ShopItem extends StatefulWidget {
  final String imgUrl;
  final String productName;
  final String productPrice;
  final double rating;
  final int review;
  final void Function()? onTap;
  const ShopItem({super.key,required this.onTap, required this.imgUrl, required this.productName, required this.productPrice, required this.review, required this.rating});

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Cmdof().custH(0.3, context),
                width: Cmdof().W(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    widget.imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(widget.productName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price: "+widget.productPrice, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),),
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
            ],
          ),
        ),
      )
      ),
    );

  }
}
