import 'package:category_app_demo/features/home_category/presentation/logic/category_cubit.dart';
import 'package:category_app_demo/features/home_category/presentation/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryHomeItem extends StatelessWidget {
  final int id;
  final String? title;
  final String? imageUrl;
  final String? backgroundColor;

  const CategoryHomeItem({
    Key? key,
    required this.id,
    this.title,
    this.backgroundColor,
    this.imageUrl,
  }) : super(key: key);

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    final subCategoryCubit = BlocProvider.of<CategoryCubit>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: hexToColor(backgroundColor!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCachedNetworkImage(
            width: 120,
            imageUrl: imageUrl.toString(),
            placeHolderAssetPath: 'assets/images/logo1st.png',
          ),
          const SizedBox(
            height: 10,
          ),
          Text(title!),
        ],
      ),
    );
  }
}
