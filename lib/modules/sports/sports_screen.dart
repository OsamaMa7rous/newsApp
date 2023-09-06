import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/shared_componant/reuseable_componant.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {

      } ,
      builder: (context, state)
      {
        List<dynamic> list = NewsCubit.get(context).sports;

        return conditionalBuilder(list: list);
      },

    ) ;
  }
}