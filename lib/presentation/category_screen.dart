
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/categories_list.dart';
import 'package:flutter_news_app/models/category.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);


  List<Category> getCategories(){
    List<Category> list = [];
    for(int i=1;i<categories.length;i++)
      {
        log(categories[i].name);
        list.add(categories[i]);
      }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    List<Category>? _list = getCategories();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context,0),
          icon: Icon(Icons.arrow_back_ios_outlined, color:  AppConstants.iconColor,),
        ),
        title: Text('Chuyên mục',
        style:  GoogleFonts.nunito(
          textStyle: TextStyle(
            fontSize: 25.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.pop(context,index+1);
              },
              child:Container(
                padding: EdgeInsets.symmetric(vertical: 20,
                horizontal: 20),
                child: Text(_list[index].name ,
                  style: GoogleFonts.nunito(
                textStyle: TextStyle(
                fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),),
              ) ,
            );
        },
      ),
    );
  }
}
