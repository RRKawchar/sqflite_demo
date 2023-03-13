import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_demo/api_demo/controller/product_controller.dart';

class PaginationScreen extends StatelessWidget {
  // const PaginationScreen({Key? key}) : super(key: key);
 final controller=Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: RefreshIndicator(
        onRefresh: (){
        return  controller.refreshProduct();
        },
        child: NotificationListener<ScrollNotification>(
          onNotification:(notification)=>controller.onScrollNotification(notification),
          child:Obx((){
             if(controller.isLoading.value){
               return const Center(child: CircularProgressIndicator(),);
             }else if(controller.productList.isEmpty){
               return const Center(child: Text("No found data"),);
             }else{
               return ListView.builder(
                 itemCount: controller.productList.length,
                   itemBuilder: (context,index){
                   final data=controller.productList[index];
                   return Column(
                     children: [
                       Container(
                         height: 200,
                         width: double.infinity,
                         child: Image.network(data.images.first.toString()??""),
                       ),
                       Text(data.name??"")

                     ],
                   );
                   }
               );
             }

          }) ,
        ),
      ),
    );
  }
}
