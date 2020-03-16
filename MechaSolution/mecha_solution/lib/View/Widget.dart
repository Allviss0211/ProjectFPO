import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/Product/DetailProductScreen.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';


var gradientColor = [Color(0xFF03A9F4),Color(0xFF039BE5),Color(0xFF0288D1),Color(0xFF0277BD),Color(0xFF01579B),];


class ListHome extends StatefulWidget {
  @override
  _ListHomeState createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  ProductAPI productAPI = new ProductAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productAPI.getListProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? ListProductHome(
                listProduct: snapshot.data,
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ListProductHome extends StatefulWidget {
  final ListProduct listProduct;
  ListProductHome({Key key, this.listProduct}) : super(key: key);

  @override
  _ListProductHomeState createState() => _ListProductHomeState();
}

class _ListProductHomeState extends State<ListProductHome> {

  ScrollController controllerProduct;
  ListProduct listProduct2 ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerProduct = new ScrollController()..addListener((){
        if (controllerProduct.position.extentAfter < 500) {
          setState(() {
            listProduct2 = widget.listProduct;
            widget.listProduct.data += listProduct2.data;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
     return ScopedModelDescendant<HomeModel>(
      builder: (BuildContext build, Widget child, HomeModel model) {
        model.listProduct = widget.listProduct;
        return ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColor)
                      ),
                    ),
                    clipper: OvalBottomBorderClipper(),
                  ),
                  Swiper(
                    itemWidth: MediaQuery.of(context).size.width,
                    itemHeight: MediaQuery.of(context).size.height / 5,
                    layout: SwiperLayout.DEFAULT,
                    autoplay: true,
                    itemCount: model.listProduct.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                model.listProduct.data[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text(
                "Danh sách sản phẩm",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
                width: double.infinity,
                height: 150,
                margin: EdgeInsets.only(top: 15),
                child: ListView.builder(
                    controller: controllerProduct,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.listProduct.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      int lenght = model.listProduct.data.length;
                      if(index > lenght)
                       {
                          index = index - lenght*(index ~/ lenght);
                       }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProductScreen(
                                        productID:
                                            model.listProduct.data[index].id,
                                      )));
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black12,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        model.listProduct.data[index].image),
                                    fit: BoxFit.cover),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              model.listProduct.data[index].name,
                            ),
                          ],
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Text(
                "Gói combo",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 150,
                margin: EdgeInsets.only(top: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
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
                                        "https://pbs.twimg.com/profile_images/1174747027986452480/cSlw47L-_400x400.png"),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              color: Colors.black87,
                              child: Text(
                                "Gói combo ${index.toString()}",
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
                  },
                )),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
              child: Text(
                "Top sản phẩm",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3 + 10,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.listProduct.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailProductScreen(
                                    productID: model.listProduct.data[index].id,
                                  )));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    model.listProduct.data[index].image),
                                fit: BoxFit.cover),
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(model.listProduct.data[index].name.toString() +
                            " " +
                            index.toString()),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5,
      clipBehavior: Clip.antiAlias,
      shape: CircularNotchedRectangle(),
      child: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.deepOrange,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Trang chủ"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Thông báo"),
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class GradientBar extends StatefulWidget {
  @override
  _GradientBarState createState() => _GradientBarState();
}

class _GradientBarState extends State<GradientBar> {

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColor)),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return scanQR();
  }
}

class scanQR extends StatefulWidget {
  @override
  _scanQRState createState() => _scanQRState();
}

class _scanQRState extends State<scanQR> {
  String result = "Hey there";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          _scanQR();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Thông tin QR"),
                  content: Text('$result'),
                );
              });
        });
  }
}


/*
Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        model.listProduct.data[0].image),
                                    fit: BoxFit.cover)),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Top sản phẩm",
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        model.listProduct.data[0].image),
                                    fit: BoxFit.cover)),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Top sản phẩm",
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
 */

/*
ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4 + 25,
                    child: Swiper(
                      autoplay: true,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return new Image(
                          image: CachedNetworkImageProvider(
                              model.listProduct.data[index].image),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Text(
                    "Danh sách sản phẩm",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 150,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.listProduct.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProductScreen(
                                        productID:
                                        model.listProduct.data[index].id,
                                      )));
                            },
                            child: Column(
                              children: <Widget>[
                                Hero(
                                  tag: 'productImage $index',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(model
                                              .listProduct.data[index].image),
                                          fit: BoxFit.cover),
                                    ),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(model.listProduct.data[index].name
                                    .toString() +
                                    " " +
                                    index.toString()),
                              ],
                            ),
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Text(
                    "Gói combo",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    height: 150,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
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
                                            "https://i.pinimg.com/236x/c5/71/cf/c571cf3b28768db808492072034e9e0e.jpg"),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  color: Colors.black87,
                                  child: Text(
                                    "Gói combo ${index}",
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
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                  child: Text(
                    "Top sản phẩm",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: GridView.builder(
                    itemCount: model.listProduct.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailProductScreen(
                                    productID:
                                    model.listProduct.data[index].id,
                                  )));
                        },
                        child: Column(
                          children: <Widget>[
                            Hero(
                              tag: 'productImage $index',
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(model
                                          .listProduct.data[index].image),
                                      fit: BoxFit.cover),
                                ),
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(model.listProduct.data[index].name
                                .toString() +
                                " " +
                                index.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
 */
