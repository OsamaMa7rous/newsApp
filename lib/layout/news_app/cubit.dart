import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/layout/remote/dio_helper.dart';
import 'package:news_app/local/cache_helper.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/setting/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsAppInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
int currentIndex = 0;
  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];

  void getBusiness (){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        path: "v2/top-headlines",
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'e4b42f30ad4d4eb78fa20693e8e1dfe5',
        },
    ).then((value) {
      business = value.data['articles'];
print("خفي نفسك ي بيزنيس");
      emit(NewsGetBusinessSuccessState());

    }).catchError((error){
      print("error while getBusiness ${error.toString()}");
      emit(NewsGetBusinessErrorState());

    });
  }
  void getScience (){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
        path: "v2/top-headlines",
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'e4b42f30ad4d4eb78fa20693e8e1dfe5',
        },
      ).then((value) {
        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());

      }).catchError((error){
        print("error while getScience ${error.toString()}");
        emit(NewsGetScienceErrorState());

      });
    }
    else{
      emit(NewsGetScienceSuccessState());

    }
  }
  void getSports (){
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
        path: "v2/top-headlines",
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'e4b42f30ad4d4eb78fa20693e8e1dfe5',
        },
      ).then((value) {

        sports = value.data['articles'];


      }).catchError((error){
        print("error while getSports ${error.toString()}");
        emit(NewsGetSportsErrorState());

      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }
 List<dynamic>  search =[];
  void getSearch(String value){

    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      path: "v2/everything",
      query:
      {
        'q':value,
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      search = value.data['articles'];

        emit(NewsGetSearchSuccessState());

    }).catchError((error){
      print("error while Search ${error.toString()}");
      emit(NewsGetSearchErrorState());

    });


}

  List<BottomNavigationBarItem> bottomItems = const[
     BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business"),
    BottomNavigationBarItem(icon:  Icon(Icons.science),label: "Science"),
    BottomNavigationBarItem(icon:  Icon(Icons.sports_volleyball_rounded),label: "Sports"),
  ];
  void changeBottomNav(int index){
    currentIndex = index;
    if(index==1){
      getScience();
    }
    else if(index==2){
      getSports();
    }
    emit(NewsAppChangeBottomNavBarState());
  }
  bool isDark = false;
  void changeThemeColor ({bool? fromShared}){
    if(fromShared != null) {
      isDark=fromShared;
    } else {
      isDark=!isDark;
      CacheHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(NewsChangeThemeColor());

      }) ;
    }


  }

}
