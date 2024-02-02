import 'package:flutter/material.dart';

import '../helper/custom_size.dart';

class SearchItem extends StatefulWidget {
  final String imgUrl;
  final String productName;
  final double productPrice;
  final double rating;
  final int review;
  final void Function()? onTap;
  const SearchItem({super.key, required this.imgUrl, required this.productName, required this.productPrice, required this.rating, required this.review, this.onTap});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 1,
            color: Colors.blue[20],
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    height: Cmdof().custH(0.03, context),
                    width: Cmdof().custW(0.1, context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        widget.imgUrl,
                        cacheHeight: 200,
                        cacheWidth: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: Cmdof().custW(0.7, context),
                          child: Text(widget.productName, maxLines: 3, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black, overflow: TextOverflow.ellipsis))),
                      Text("Price USD "+widget.productPrice.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black54),),
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
