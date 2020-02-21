import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _featureProduct(BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.elektor.com%2Fmedia%2Fcatalog%2Fproduct%2Fcache%2F2b4bee73c90e4689bbc4ca8391937af9%2Fr%2Fa%2Fraspberry-pi-4-4gb.jpg&imgrefurl=https%3A%2F%2Fwww.elektor.com%2Fraspberry-pi-4-b-4-gb-ram&tbnid=peUGMIsadthfFM&vet=12ahUKEwjirbqJ1-HnAhXBNHIKHYNmDmkQMygBegUIARDLAQ..i&docid=uTHXETEkgbffsM&w=800&h=800&itg=1&q=raspberry%20pi%204&ved=2ahUKEwjirbqJ1-HnAhXBNHIKHYNmDmkQMygBegUIARDLAQ"),
                  fit: BoxFit.cover)),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 150,
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.black87,
            child: Text(
              "Gói combo",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}


Widget _categoryProduce(BuildContext context){
  return InkWell(
    onTap: (){},
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
            image: DecorationImage(
              image: CachedNetworkImageProvider("https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.elektor.com%2Fmedia%2Fcatalog%2Fproduct%2Fcache%2F2b4bee73c90e4689bbc4ca8391937af9%2Fr%2Fa%2Fraspberry-pi-4-4gb.jpg&imgrefurl=https%3A%2F%2Fwww.elektor.com%2Fraspberry-pi-4-b-4-gb-ram&tbnid=peUGMIsadthfFM&vet=12ahUKEwjirbqJ1-HnAhXBNHIKHYNmDmkQMygBegUIARDLAQ..i&docid=uTHXETEkgbffsM&w=800&h=800&itg=1&q=raspberry%20pi%204&ved=2ahUKEwjirbqJ1-HnAhXBNHIKHYNmDmkQMygBegUIARDLAQ"),
              fit: BoxFit.cover
            ),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 100,
          height: 100,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Raperri 3"),
      ],
    ),
  );
}