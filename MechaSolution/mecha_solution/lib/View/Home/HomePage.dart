import 'package:flutter/material.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/ProductItem.dart';
import 'package:mecha_solution/View/SignIn/ProductSrceen.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:scoped_model/scoped_model.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int _count = -1;
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
                          "${listproduct[i]
                              .children[_count < listproduct[i].children.length ? ++_count : _count = 0].title}"),
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
              gradient:
                  new LinearGradient(colors: [Colors.lightBlue, Colors.black87]),
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
                children:
                    _listOfProduct.map((expansionTile) => expansionTile).toList(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            AlertDialog dialog = new AlertDialog(
              title: Text("You were tapped"),
            );
            showDialog(context: context, child: dialog);
          },
        ),
        body: listProductHome(),
        bottomNavigationBar: BottomNavigationBar(
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

  Widget listProductHome() => ScopedModelDescendant<HomeModel>(
          builder: (BuildContext context, Widget child, HomeModel model) {
        return ListView.builder(
            itemCount: model.listProduct.data.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: model.listProduct.data[index],
                onClick: (product) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductScreen(
                        model.listProduct.data.indexOf(product),
                        model.listProduct.data);
                  }));
                },
              );
            });
      });
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
