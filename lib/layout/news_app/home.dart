import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/layout/remote/dio_helper.dart';
import 'package:news_app/local/cache_helper.dart';
import 'package:news_app/modules/search/search.dart';
import 'package:news_app/shared_componant/reuseable_componant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(
                onPressed: () {

                  navigateTo(context, SearchScreen());

                },
                icon: const Icon(
                  Icons.search,
                ),
                iconSize: 30.0,
              ),
              IconButton(
                onPressed: () {
                  cubit.changeThemeColor();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
                iconSize: 30.0,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottomNav(value);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
