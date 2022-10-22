import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
static String name ="";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 List<Category> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${HomeScreen.name}"),
        centerTitle: true,
      ),
      body: Container(
         child:buildLoadedWidget() ,
      ),
    ) ;
  }

  Widget buildLoadedWidget() => SizedBox(
      width: double.infinity,
      child: GridView.builder(
        itemCount:list.length ,
        itemBuilder: (context, index) =>
            ListItem(item: list[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          childAspectRatio: 1 / 1.4,
        ),
      ));

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final res = await FirebaseFirestore.instance
        .collection('categories')
        .get();
    for (var element in res.docs) {
      list.add(Category.fromJson(element.data()));
    }
    setState(() {});
  }
}
class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
class ListItem extends StatelessWidget {
  final Category item;
  const ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (_)=>))
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(3.5),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.grey,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              item.name!,
              style: const TextStyle(
                height: 1.3,
                fontSize: 14,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Container(
            color: Colors.white,
            child: Hero(
              tag: item.image!,
              child: FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/image_loading.gif',
                image: item.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
