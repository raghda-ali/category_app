import 'package:category_app_demo/features/home_category/data/models/category_model.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/presentation/logic/category_cubit.dart';
import 'package:category_app_demo/features/home_category/presentation/widgets/category_item.dart';
import 'package:category_app_demo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel? category;

  const CategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: Text("Loading"));
          } else if (state is CategorySuccess) {
            return Column(
              children: [
                const SizedBox(height: 70,),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.5),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        mainAxisExtent: 130,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: state.homeCategoryList.length,
                      itemBuilder: (context, index) => CategoryHomeItem(
                        id: state.homeCategoryList[index].id,
                        title: state.homeCategoryList[index].name,
                        imageUrl: state.homeCategoryList[index].image,
                        backgroundColor: state.homeCategoryList[index].color,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CategoryEmpty) {
            return Text("Empty");
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}
