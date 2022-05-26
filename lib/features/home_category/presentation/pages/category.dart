import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              bottom:
              MediaQuery.of(context).size.height * 0.5),
          gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisExtent: 130,
            crossAxisSpacing: 1,
            mainAxisSpacing: 20,
          ),
          itemCount: categoryCubit.categoriesList.length,
          itemBuilder: (context, index) => CategoryHomeItem(
            id: categoryCubit.categoriesList[index].id!,
            title: categoryCubit
                .categoriesList[index].nameOfCategory,
            imageUrl: categoryCubit
                .categoriesList[index].imageOfCategory,
            backgroundColor: categoryCubit
                .categoriesList[index].backGroundColor,
          ),
        ),
      ),
    );
  }
}
