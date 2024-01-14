import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoshua_ui_test/helper/custom_size.dart';
import 'package:yoshua_ui_test/util/NoOverScrollGlow.dart';
import 'package:yoshua_ui_test/widget/navigators.dart';
import 'package:yoshua_ui_test/widget/saerch_item.dart';

import '../../api/endpoint/product/get_product_response.dart';
import '../../widget/FlushBar.dart';
import '../product_detail_page/product_detail_page.dart';
import 'bloc/search_page_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  bool isLoading = false;
  List<ProductResponse> productsData = [];
  List<ProductResponse> backupProductsData = [];
  String? searchKey;
  final TextEditingController _searchKey = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchPageBloc>().add(GetAllProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SearchPageBloc, SearchPageState>(
        listener: (context, state) {
          if (state is onGetProductsSuccess){
            setState(() {
              productsData.clear();
              productsData = state.data;
              backupProductsData = state.data;
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
        child: Body(),
      ),
      appBar: appbar(),
    );
  }

  AppBar? appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 30,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
    );
  }

  Widget Body() {
    return SafeArea(
        child: Column(
          children: [
            Container(
                height: Cmdof().custH(0.07, context),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                    controller: _searchKey,
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[50],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20
                        ),
                        hintText: 'Search item..',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500
                        )
                    ),
                    onChanged: (value) {
                      setState(() {
                        if(_searchKey.text.isEmpty){
                          productsData.clear();
                          productsData.addAll(backupProductsData);
                        }
                      });
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      if(_searchKey.text.isEmpty){
                        productsData.clear();
                        productsData.addAll(backupProductsData);
                      }else{
                       _filterProducts();
                      }
                    }
                )
            ),
            isLoading ? SizedBox() :
            Expanded(
              child: ScrollConfiguration(
                  behavior: NoOverscrollBehavior(),
                  child: ListView.builder(
                    itemCount: productsData.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      ProductResponse data = productsData[index];
                      return SearchItem(
                        productName: data.title,
                        review: data.rating.count,
                        imgUrl: data.image,
                        productPrice: data.price,
                        rating: data.rating.rate,
                        onTap: () {
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
                  )
              ),
            )

          ],
        )
    );
  }

  void _filterProducts() {
    setState(() {
      productsData = backupProductsData.where((product) =>
          product.title.toLowerCase().contains(_searchKey.text.toLowerCase())
      ).toList();
      _searchKey.clear();
    });
  }

}
