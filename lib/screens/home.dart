import 'dart:convert';

import 'package:fetch_data_api/models/product.dart';
import 'package:fetch_data_api/utils/cardscreen.dart';
import 'package:flutter/material.dart';

//must add this to work with http
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //we will get a list of product from the api
  List<Product> products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchProducts();
  }

  Future<void> fetchProducts() async {
    // you can replace your api link with this link
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        products = jsonData.map((data) => Product.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fetching Data From API', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),),
      body: ListView.builder(
        // this give the length of item
        itemCount: products.length,
        itemBuilder: (context, index) {
          // here we call the card widget
          // which is in utils folder
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}




