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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(userRepository: userRepository)
          ..add(UpdateHomeEvent(selectedIndex: selectedIndex)),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
          if (homeState is HomeLoadingDataState)
            return Scaffold(
              appBar: _appBar(context),
              body: Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          else if (homeState is HomeLoadDataSuccessState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: _appBar(context),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: ListView.builder(
                          //key: Key(categories.length),
                          controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      UpdateHomeEvent(selectedIndex: index));
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
                            })),
                  ),
                  Expanded(
                    flex: 10,
                      child: ListView.builder(
                          itemCount: homeState.news.length,
                          itemBuilder: (context, index) {
                            return ArticleTile(article: homeState.news[index]);
                          }))
                ],
              ),
            );
          }
          return Scaffold(
            appBar: _appBar(context),
            body: Center(
              child: Container(
                child: Text('Error'),
              ),
            ),
          );
        }));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.menu,
        color: Colors.black38,
      ),
      title:
      Image.network(
        'https://s.vnecdn.net/vnexpress/i/v20/logos/vne_logo_rss.png',
        // article.thumbnail!,
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
            icon: Icon(Icons.exit_to_app, color:Colors.black38)),
      ],
    );
  }
}
