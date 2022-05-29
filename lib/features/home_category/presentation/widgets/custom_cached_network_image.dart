
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String placeHolderAssetPath;
  final double? height;
  final double? width;
  const CustomCachedNetworkImage(
      {Key? key,
        required this.imageUrl,
        required this.placeHolderAssetPath,
        this.height,
        this.width,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? 60,
      height: height ?? 60,
      imageUrl: imageUrl,
      filterQuality: FilterQuality.medium,
      // cacheManager: CacheManager(
      //   Config(
      //     'customCacheKey',
      //     stalePeriod: const Duration(days: 3),
      //     maxNrOfCacheObjects: 50,
      //   ),
      // ),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[100]!,
          highlightColor: Colors.grey[200]!,
          child: const CupertinoActivityIndicator(
            radius: 15,
            color: Colors.black,
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[100]!,
            highlightColor: Colors.grey[200]!,
            child: Image.asset(placeHolderAssetPath),
          ),
        );
      },
    );
  }
}
