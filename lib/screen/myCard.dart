import 'package:flutter/material.dart';
import 'productDetail.dart';
import '../admin pages/removeProduct.dart';

class MyCard extends StatelessWidget {
  final product;
  final admin;

  MyCard({this.product, this.admin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        admin ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RemovePage(
              product: product,
            ),
          ),
        ):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              product: product,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  product.data()["url"],
                  height: 300,
                  width: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product.data()["title"],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          child: Text(
                            product.data()["price"]+" RWF",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
