import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/bloc/home/home_bloc.dart';
import 'package:flutter_news_app/bloc/home/home_event.dart';
import 'package:flutter_news_app/bloc/home/home_state.dart';
import 'package:flutter_news_app/models/categories_list.dart';
import 'package:flutter_news_app/presentation/category_screen.dart';
import 'package:flutter_news_app/presentation/constants.dart';
import 'package:flutter_news_app/presentation/home/widgets/article_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_news_app/models/user.dart';

import 'package:flutter_news_app/repositories/user_repository.dart';


class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;

  HomeScreen({required this.userRepository});
  // TabController _tabController ;
  int selectedIndex = 0;
  ScrollController _scrollController = ScrollController();
  bool onTap= false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(userRepository: userRepository)
          ..add(UpdateHomeEvent(selectedIndex: selectedIndex)),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
          if (homeState is HomeLoadingDataState)
            return SafeArea(
              child: Scaffold(
                appBar: _appBar(context),
                body: Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          else if (homeState is HomeLoadDataSuccessState) {
            /*  return DefaultTabController(
                initialIndex: 0,
                length: categories.length,
                child: Builder( builder: (BuildContext context){*/
//_scrollController.animateTo(homeState.selectedIndex*10.0, duration: new Duration(seconds: 1), curve: Curves.ease);


                  return Scaffold(
                    backgroundColor: Colors.white,
                    appBar:_appBar(context),
                    body:
                    Column(
                     children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.topLeft,
                         child:

                           ListView.builder(
                                //  reverse: true,
                               //   cacheExtent: 3,
                                  physics: ScrollPhysics(),
                                  addAutomaticKeepAlives: false,
                                  //key: Key(categories.length),
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index)   {
                                    log(homeState.selectedIndex.toString()+' '+index.toString());
                                    log((onTap==true &&  homeState.selectedIndex==index).toString());
                                    if (onTap==true &&   homeState.selectedIndex==index)
                                    {
                                       _scrollController.animateTo( homeState.selectedIndex*60.0, duration:  Duration(microseconds: 1), curve: Curves.ease);
                                    }
                                    if (onTap==true &&   homeState.selectedIndex==8)
                                    {
                                      _scrollController.animateTo( homeState.selectedIndex*60.0, duration:  Duration(microseconds: 1), curve: Curves.ease);
                                    }
                                    return GestureDetector(
                                      key: Key(index.toString()),
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context).add(
                                            UpdateHomeEvent(selectedIndex: index));
                                        onTap=true;

                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 10.h),
                                        height: 50.h,
                                        child: Text(
                                          categories[index].name,
                                          style: homeState.selectedIndex == index
                                              ? AppConstants.activeStyle
                                              : AppConstants.unActiveStyle,
                                        ),
                                      ),
                                    );
                                  })
                           ),
                       ),
                         Expanded(
                           flex: 10,
                           child: ListView.builder(
                                  itemCount: homeState.news.length,
                                  itemBuilder: (context, index) {
                                    return   ArticleTile(article: homeState.news[index]);
                                  }),
                         )
                   //   )
                    ],
                  ),
               //   );}
              //  ),

            );
          }
          return SafeArea(child:  Scaffold(
            appBar: _appBar(context),
            body: Center(
              child: Container(
                child: Text('Error'),
              ),
            ),
          ));
        }));
  }



  Widget tabItem(BuildContext context, int index,)
  {
    return  GestureDetector(
      onTap: () {
        //
        // BlocProvider.of<HomeBloc>(context).add(
        //     UpdateHomeEvent(selectedIndex: index));
      //  log(DefaultTabController.of(context)!.index.toString());
         DefaultTabController.of(context)!.index=index;
      log(DefaultTabController.of(context)!.index.toString());
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 10.h, horizontal: 10.h),
        height: 50.h,
        child: Text(
          categories[index].name,
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
    //  bottom:
      /*TabBar(
          onTap: (index)
          {
            log(index.toString()+'_____________');
            BlocProvider.of<HomeBloc>(context).add(
                UpdateHomeEvent(selectedIndex: index));
            //  log(DefaultTabController.of(context)!.index.toString());
            //    DefaultTabController.of(context)!.index=index;
          },
          labelColor: Colors.black,
          unselectedLabelColor: AppConstants.unActiveColor,
          unselectedLabelStyle: AppConstants.unActiveStyle,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelStyle: AppConstants.activeStyle,
          tabs:[
            tabItem(context, 0),
            tabItem(context, 1),
            tabItem(context, 2),
            tabItem(context, 3),
            tabItem(context, 4),
            tabItem(context, 5),
            tabItem(context, 6),
            tabItem(context, 7),
            tabItem(context, 8),

          ]
      ),*/
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () async {
          selectedIndex = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => CategoryScreen()));
        BlocProvider.of<HomeBloc>(context).add(
        UpdateHomeEvent(selectedIndex: selectedIndex));
         // DefaultTabController.of(context)!.index=selectedIndex;
        },
        child: Icon(
            Icons.menu,
            color:  AppConstants.iconColor
        ),
      ),
      title: Image.network(
        'https://s.vnecdn.net/vnexpress/i/v20/logos/vne_logo_rss.png',
        height: 64.h,
        width: ScreenUtil().screenWidth,
        fit: BoxFit.fitHeight,
      ),
      actions: [
        IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(SignedOutEvent());
            },
            icon: Icon(Icons.exit_to_app, color: AppConstants.iconColor)),
      ],
    );
  }
}