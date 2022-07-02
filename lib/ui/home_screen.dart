import 'package:flutter/material.dart';
import 'package:otp_final/network/network.dart';

import '../model/products_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  late List<Result> productsList;
  String errorText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              // FutureBuilder<dynamic>(
              //   future: HttpApi().getProducts(),
              //   builder: (context, snapshotData) {
              //     if (snapshotData.hasData) {
              //       if (snapshotData.data is List<Result>) {
              //         productsList = snapshotData.data;
              //         return Expanded(
              //             child: ListView.builder(
              //                 itemCount: snapshotData.data.length,
              //                 itemBuilder: (context, index) {
              //                   return product(
              //                       snapshotData.data[index].imageUrl,
              //                       snapshotData.data[index].title,
              //                       snapshotData.data[index].rated);
              //                 }));
              //       } else {
              //         return Text(snapshotData.data);
              //       }
              //     } else {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //   },
              // )

              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: productsList.length,
                          itemBuilder: (context, index) {
                            return product(
                                productsList[index].imageUrl,
                                productsList[index].title,
                                productsList[index].rated);
                          })),
        ),
      ),
    );
  }

  Widget product(String imageUrl, String title, String price) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
        ),
        title: Text(title),
        subtitle: Text(price),
      ),
    );
  }

  void getProductsFromAPI() async {
    var result = await HttpApi().getProducts();
    if (result is List<Result>) {
      productsList = result;
    } else {
      errorText = result;
    }
    setState(() {
      isLoading = false;
    });
  }
}
