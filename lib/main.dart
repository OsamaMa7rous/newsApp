import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit.dart';
import 'package:news_app/layout/news_app/home.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/layout/remote/dio_helper.dart';
import 'package:news_app/local/cache_helper.dart';
import 'package:news_app/shared_componant/cubit_observe/observable.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
await CacheHelper.init();
 bool? isDark = CacheHelper.getBoolean(key: "isDark");
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp( MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
final bool? isDark;
 MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>NewsCubit()..getBusiness()..getScience()..getSports()..changeThemeColor(fromShared: isDark),

      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
         return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme:  ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  iconTheme:  const IconThemeData(
                    color: Colors.white,
                    size: 30.0,
                  ),
                  backgroundColor:HexColor('333739'),
                  elevation: 0.0,
                  systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: HexColor('333739'),
                    systemNavigationBarColor: HexColor('333739'),
                  ),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('333739'),
                  elevation: 20.0,
                ),
                textTheme: const TextTheme(

                    bodyText1: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,

                    )
                )),
            themeMode:NewsCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
            theme: ThemeData(
                textTheme: const TextTheme(

                    bodyText1: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,

                    )
                ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                    size: 30.0,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.grey[300]),
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  type: BottomNavigationBarType.fixed,
                  elevation: 20.0,
                )),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
