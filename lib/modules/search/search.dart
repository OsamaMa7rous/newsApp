import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/shared_componant/reuseable_componant.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder:(context, state) {
        var list=NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: defaultTextFormFiled(
                onChange: (value) {
                  NewsCubit.get(context).getSearch(value);
                },
                controller: searchController,
                type: TextInputType.text,
                validator: (value) {},
                prefix: Icons.search,
                label: "Search",
              ),
            ),
            Expanded(child: conditionalBuilder(list: list))
          ],
        ),
      );
      },
      listener: (context, state) {

      },

    );
  }
}
