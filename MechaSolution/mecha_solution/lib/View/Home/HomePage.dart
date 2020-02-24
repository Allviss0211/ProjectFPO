import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/SignIn/ProductSrceen.dart';
import 'package:mecha_solution/View/SignIn/ProductSrceen.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller;
  static int _count = -1;
  final List<String> images = [
    "https://i.pinimg.com/236x/ea/63/bd/ea63bd0226462d0dac4476cddc9d80ec.jpg",
    "https://i.pinimg.com/236x/ad/58/d8/ad58d82c6044628404141c139208afa0.jpg",
    "https://i.pinimg.com/236x/c8/46/01/c846014a90f7478c2c6c88e53f80b186.jpg",
    "https://i.pinimg.com/236x/8e/b7/55/8eb755d16b2c2bd0b301f07f28048112.jpg",
    "https://i.pinimg.com/236x/91/41/41/914141f1d8df24c24e1c3e4118d1c6f2.jpg"
  ];

  @override
  void initState(){
    super.initState();
    controller = new ScrollController()..addListener(_listenScroll);
  }

  @override
  void dispose(){
    controller.removeListener(_listenScroll);
    super.dispose();
  }

  ProductAPI productAPI = new ProductAPI();

  int _currentIndex = 0;

  List<ExpansionTile> _listOfProduct = List<ExpansionTile>.generate(
      listproduct.length,
      (i) => ExpansionTile(
            title: Text(
              listproduct[i].title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            leading: Icon(Icons.settings),
            children: listproduct[i]
                .children
                .map((data) => ListTile(
                      leading: SizedBox(
                        width: 30,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text(
                          "${listproduct[i].children[_count < listproduct[i].children.length ? ++_count : _count = 0].title}"),
                      onTap: () {},
                    ))
                .toList(),
          ));

//  Icon _searchIcon = new Icon(
//    Icons.search,
//    color: Colors.white,
//  );

  Widget _appBarTitle = new Text(
    "MechaSolution",
    style: TextStyle(color: Colors.white),
  );
  Widget txtSearch = new TextField(
    decoration: new InputDecoration(
      border: false ? OutlineInputBorder() : InputBorder.none,
      hintText: "Search here",
      hintStyle: TextStyle(color: Color(0xffd8d8d8)),
    ),
    style: TextStyle(fontSize: 20, color: Colors.white),
  );
  ListView listProduct = new ListView(
    scrollDirection: Axis.horizontal,
  );

//  void _searchPress() {
//    setState(() {
//      if (this._searchIcon.icon == Icons.search) {
//        this._searchIcon = new Icon(
//          Icons.cancel,
//          color: Colors.white,
//        );
//        this._appBarTitle = Container(
//          child: txtSearch,
//          width: 180,
//        );
//      } else {
//        this._searchIcon = new Icon(
//          Icons.search,
//          color: Colors.white,
//        );
//        this._appBarTitle = new Text(
//          "MechaSolution",
//          style: TextStyle(color: Colors.white),
//        );
//      }
//    });
//  }

  void _onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: HomeModel.getInstance(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: _appBarTitle,
              ),
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  onPressed: null),
            ],
          ),
          flexibleSpace: new Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.lightBlue, Colors.black87]),
            ),
          ),
//        bottom: PreferredSize(
//          preferredSize: Size.fromHeight(50),
//          child: Container(
//            child: Row(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(left: 15, right: 5),
//                  child: Icon(
//                    Icons.search,
//                    size: 30,
//                    color: Colors.black,
//                  ),
//                ),
////                VerticalDivider(
////                  color: Colors.black,
////                  width: 10.0,
////                ),
//                Container(
//                  child: txtSearch,
//                  padding: EdgeInsets.only(left: 5),
//                  width: 340,
//                ),
//              ],
//            ),
//            decoration: BoxDecoration(
//              color: Colors.white,
//            ),
//          ),
//        ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              drawerUserHeader(),
              Column(
                children: _listOfProduct
                    .map((expansionTile) => expansionTile)
                    .toList(),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            _showSearchModal(context);
          },
        ),
        body: SafeArea(child: listProductHome()),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTapTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Trang chủ"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text("Thông báo"),
            ),
          ],
        ),
      ),
    );
  }

  Widget listProductHome() => ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only( bottom: 10),
            child: _buildSlider(),
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
                  controller: controller,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _categoryProduce(context, index < 5 ? index : index - (5 * (index ~/ 5)));
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
                  return _featureProduct(context,index);
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
            child: Text("Top sản phẩm", style: Theme.of(context).textTheme.title,),
          ),
         _topProduct(),
        ],
      );

  Widget _categoryProduce(BuildContext context, int index) {
    return new InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      images[index]),
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
          Text("Raperri " + index.toString()),
        ],
      ),
    );
  }

  Widget _featureProduct(BuildContext context, int index) {
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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
  }

  Widget _topProduct() {
    return Container(
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
                          image: CachedNetworkImageProvider(images[0]),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "2 củ",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
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
                          image: CachedNetworkImageProvider(images[0]),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "2 củ",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
      height: 160.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: DiagonalPathClipperOne(),
          child: Container(
            height: 110,
            color: Colors.deepPurpleAccent,
          ),
          ),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.0)),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
            child : Swiper(
              autoplay: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index){
                return new Image(image: CachedNetworkImageProvider(images[index]),
                fit: BoxFit.cover,);
              },
            )
          )
        ],
      ),
    );
  }

  void _listenScroll(){
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 2) {
      setState(() {
        images.addAll(new List.generate(10, (index) => 'index'));
      });
    }
  }
}

class Product {
  String title;
  List<Product> children;
  Product(this.title, [this.children = const <Product>[]]);
}

List<Product> listproduct = <Product>[
  new Product(
    'Sản phẩm',
    <Product>[
      new Product('IoT'),
      new Product('Máy tính nhúng'),
      new Product('Module'),
      new Product('Mạch điện'),
      new Product('Cảm biến'),
      new Product('Robot'),
      new Product('Máy in / Scan 3D'),
      new Product('Blog'),
    ],
  ),
  new Product(
    'Nhiều hơn trên MechaSolution',
    <Product>[
      new Product('Mời bạn bè'),
      new Product('Liên lạc với chúng tôi'),
      new Product('Đánh giá và khảo sát'),
    ],
  ),
];

Widget drawHeader() {
  return DrawerHeader(
    decoration: BoxDecoration(
      color: Color(0xffd8d8d8),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 55,
          height: 55,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: FlutterLogo(),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Hi, Nguyễn Văn Anh',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              child: Text(
                'Chào mừng trở lại',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Container(
          child: Icon(Icons.arrow_forward_ios),
          padding: EdgeInsets.only(left: 5),
        ),
      ],
    ),
  );
}

Widget drawerUserHeader() {
  return UserAccountsDrawerHeader(
    currentAccountPicture: CircleAvatar(
      child: FlutterLogo(
        size: 42,
      ),
      backgroundColor: Colors.white,
    ),
    accountName: Text(
      "Nguyễn Văn Anh",
      style: TextStyle(fontSize: 18),
    ),
    accountEmail: Text(
      "Chào mừng trở lại",
      style: TextStyle(fontSize: 13),
    ),
  );
}

BottomAppBar bottomAppbar() {
  return BottomAppBar(
    color: Colors.white,
    shape: CircularNotchedRectangle(),
    child: Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.home,
                size: 30,
              ),
              Text(
                "Trang chủ",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.view_module),
              Text("Danh mục"),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.notifications),
              Text("Thông báo"),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.person_outline),
              Text("Tài khoản"),
            ],
          ),
        ],
      ),
    ),
  );
}

void _showSearchModal(context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SearchBottomModel(),
  );
}

class SearchBottomModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 3,
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: Color(0xFFF4F5F4),
            ),
          ),
          SizedBox(height: 18),
          SearchBar(margin: EdgeInsets.all(0)),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 18),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    this.margin = const EdgeInsets.symmetric(horizontal: 28),
  }) : super(key: key);

  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      margin: margin,
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search),
          SizedBox(width: 13),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm ở đây",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0x64303943),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
