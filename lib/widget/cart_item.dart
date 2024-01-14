import 'package:flutter/material.dart';

import '../helper/custom_size.dart';

class CartItem extends StatefulWidget {
  final double rating;
  final int review;
  final String imgUrl;
  final String productName;
  final double productPrice;
  final int productQuantity;
  final void Function()? onTapDelete;
  final void Function()? onTapAddQuantity;
  final void Function()? onTapDecreaseQuantity;
  CartItem({super.key, required this.rating, required this.review, required this.imgUrl,required this.productName, required this.productPrice, required this.productQuantity, required this.onTapAddQuantity, required this.onTapDelete, required this.onTapDecreaseQuantity});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 1,
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: Cmdof().custH(0.07, context),
                  width: Cmdof().custW(0.2, context),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text(widget.productName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price: "+widget.productPrice.toString(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54),),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: widget.onTapAddQuantity,
                    child: Icon(Icons.add, color: Colors.black, size: 25,),
                  ),
                  Text(widget.productQuantity.toString(), style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black),),
                  InkWell(
                    onTap: widget.onTapDecreaseQuantity,
                    child: Icon(Icons.remove, color: Colors.black, size: 25,),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}
