import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/custom_size.dart';
import 'bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbar(),
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text
              ],
            ),
          )
        ),
      ),
    );
  }

  AppBar? appbar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 30,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.people, size: 30, color: Colors.black,),
          const Text("TestingUI", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
          Row(
            children: [
              IconButton(
                  onPressed: () {
               setState(() {

               });
              }, icon: Icon(Icons.search, size: 25, color: Colors.black,)
              ),
              IconButton(
                  onPressed: () {
                    setState(() {

                    });
                  }, icon: Icon(Icons.shopping_cart, size: 25, color: Colors.black,)
              )
            ],
          )
        ],
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
    );
  }
}
