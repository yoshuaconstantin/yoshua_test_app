import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoshua_ui_test/api/endpoint/product/get_product_response.dart';
import 'package:yoshua_ui_test/util/NoOverScrollGlow.dart';

import '../../api/endpoint/cart/add_new_cart_request_data.dart';
import '../../api/endpoint/cart/get_user_cart_response.dart';
import '../../helper/custom_size.dart';
import '../../widget/FlushBar.dart';
import '../../widget/cart_item.dart';
import 'bloc/cart_page_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  bool isLoading = false;

  int totalCart = 0 ;
  int totalItem = 0 ;
  
  List<GetCartResponse> cartData = [];
  List<ProductResponse> productData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartPageBloc>().add(GetUserCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartPageBloc, CartPageState>(
  listener: (context, state) {
    if (state is onGetCartLoading){
      setState(() {
        isLoading = true;
      });
    } else if (state is onGetCartFailed){
      FlushBarWidget.showFailure(state.message)
          .show(context);
    } else if (state is onGetCartSuccess){
      setState(() {
        cartData = state.data;
        for(var e in cartData[0].product){
          totalItem += e.quantitiy;
        }
        List<int> listId = [];

        for(var e in cartData[0].product){
          listId.add(e.productId);
        }

        context.read<CartPageBloc>().add(GetSingleProduct(id: listId));

      });
    } else if (state is onGetCartFinished){
      setState(() {
        isLoading = false;
      });
    } else if (state is onGetSingleProductFailed){
      FlushBarWidget.showFailure(state.message)
          .show(context);
    } else if (state is onGetSingleProductSuccess){
      setState(() {
        productData.addAll(state.data);
        calculateCartTotal();
      });
    }
    // TODO: implement listener
  },
  child: Body(),
),
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
    return productData.isEmpty ? SizedBox() :
    ScrollConfiguration(
        behavior: NoOverscrollBehavior(),
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 0.650
          ),
          itemCount: productData.length,
          itemBuilder: (context, index) {
            ProductResponse data = productData[index];
            CartProductItem  quantity =  cartData[0].product[index];
            return CartItem(
              rating: data.rating.rate,
              productQuantity: quantity.quantitiy,
              productPrice: data.price,
              productName: data.title,
              onTapDelete: null,
              onTapDecreaseQuantity: (){
                setState(() {
                  if(quantity.quantitiy > 1) {
                    quantity.quantitiy--;
                    totalItem--;
                    totalCart = totalCart - int.parse(data.price.toStringAsFixed(0));
                  }
                });
              },
              onTapAddQuantity: (){
                setState(() {
                    quantity.quantitiy++;
                    totalItem = cartData[0].product.fold(0, (sum, item) => sum + item.quantitiy);
                    totalCart = totalCart + int.parse(data.price.toStringAsFixed(0));


                });
              },
              imgUrl: data.image,
              review: data.rating.count,
            );
          },
        ),
    );

  }

  Widget BottomNavBar(){
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: Cmdof().W(context),
        height: Cmdof().custH(0.1, context),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
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

  void calculateCartTotal(){
    for(var e in cartData){
      for(var f in productData){
        for(var g in e.product){
          if(f.id == g.productId){
            totalCart += (int.parse(f.price.toStringAsFixed(0)) * g.quantitiy).toInt();
          }
        }
      }
    }
  }

}
