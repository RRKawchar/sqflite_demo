import 'package:flutter/material.dart';
import 'package:sqlite_demo/practice_demo/product_details_screen.dart';

class ChiliScreen extends StatelessWidget {
  ChiliScreen({Key? key}) : super(key: key);
  var images = [
    {
      'id': '1',
      'image': "https://www.pngmart.com/files/22/Green-chili-PNG-HD.png",
      'productName': "Green Chili",
      'price': "35.8",
      'description': "Lorem Ipsum is simply dummy text of the"
          " printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer"
          " took a galley of type and scrambled it to make a type specimen "
          "book. It has survived not only five centuries"
    },
    {
      'id': '2',
      'image':
          "https://freepngimg.com/thumb/pepper/37-red-chili-pepper-png-image.png",
      'productName': "Red Chili",
      'price': "44.8",
      'description': "Lorem Ipsum is simply dummy text of the"
          " printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer"
          " took a galley of type and scrambled it to make a type specimen "
          "book. It has survived not only five centuries"
    },
    {
      'id': '3',
      'image':
          "https://i.pinimg.com/originals/31/08/47/3108475d8fd5d302cbcd7b6e945e8e2d.png",
      'productName': "Red and Green Chili",
      'price': "44.8",
      'description': "Lorem Ipsum is simply dummy text of the"
          " printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer"
          " took a galley of type and scrambled it to make a type specimen "
          "book. It has survived not only five centuries"
    },
    {
      'id': '4',
      'image': "https://freepngimg.com/thumb/tomato/6-tomato-png-image.png",
      'productName': "Tomato",
      'price': "333.8",
      'description': "Lorem Ipsum is simply dummy text of the"
          " printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer"
          " took a galley of type and scrambled it to make a type specimen "
          "book. It has survived not only five centuries"
    },
    {
      'id': '5',
      'image':
          "https://freepngimg.com/save/163593-fresh-pic-onion-free-transparent-image-hd/2369x1565",
      'productName': "Onion",
      'price': "40.8",
      'description': "Lorem Ipsum is simply dummy text of the"
          " printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer"
          " took a galley of type and scrambled it to make a type specimen "
          "book. It has survived not only five centuries"
    },
    {
      'id': '6',
      'image': 'https://www.pngmart.com/files/1/Chicken-Meat-PNG-File.png',
      'productName': "Chicken Meat",
      'price': "250.8",
      'description': "Lorem Ipsum is simply dummy text of the"
          " printing and typesetting industry. Lorem Ipsum has been the industry's"
          " standard dummy text ever since the 1500s, when an unknown printer"
          " took a galley of type and scrambled it to make a type specimen "
          "book. It has survived not only five centuries"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery"),
      ),
      body: ListView(
        children: List.generate(images.length, (index) {
          final image = images[index]['image'];
          final name = images[index]['productName'];
          final description = images[index]['description'];
          final price = images[index]['price'];
          final id = images[index]['id'];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    name: name.toString(),
                                    description: description.toString(),
                                    image: image.toString(),
                                    price: price.toString(),
                                  )));
                    },
                    child: Container(
                      height: 200,
                      width: size.width,
                      child: Image.network(images[index]['image'].toString()),
                    ),
                  ),
                  Text("\$${images[index]['price']}"),
                  Text(images[index]['productName'].toString()),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
