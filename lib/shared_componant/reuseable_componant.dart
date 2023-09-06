import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modules/webview/webview.dart';

void navigateTo(BuildContext context ,Widget builder ){
  Navigator.push(context, MaterialPageRoute(builder:(context) => builder, ));
}
Widget defaultTextFormFiled({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String> validator,
  required IconData prefix,
  required String label,
  IconData? suffix,
  bool isClickable = true,
  bool obscure = false,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  ValueChanged<String>? onChange
}) =>
    TextFormField(
      obscureText: obscure,
      validator: validator,
      enabled: isClickable,
      onTap: onTap,
      onChanged: onChange,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        )
            : null,
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
    );


Widget buildArticleItem({
  required  article,
  required BuildContext context
}){

  return  InkWell(
    onTap: (){
      navigateTo(context, View(article['url']));

    },
    child: Padding(padding: const EdgeInsets.all(10.0),
      child: Row(

        children: [

          Container(
            height: 150.0,
            width: 150.0,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage("${article['urlToImage']}"),
                fit: BoxFit.cover,

              ),
            ),
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Expanded(

                    child: Text(
                      "${article['title']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,

                      style:Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    "${article['publishedAt']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),),
  );
}
Widget separatorBuilder(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 1,
      color: Colors.grey[500],
    ),
  );
}

Widget conditionalBuilder({required List<dynamic> list}){
  return ConditionalBuilder(
    condition:list.isNotEmpty,
    builder: (context) {
      return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticleItem(article: list[index],context: context),
          separatorBuilder: (context, index) => separatorBuilder(),
          itemCount: list.length);
    },
    fallback: (context) => const Center(child: CircularProgressIndicator()),);
}