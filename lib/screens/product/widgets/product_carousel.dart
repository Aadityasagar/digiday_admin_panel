import 'package:carousel_slider/carousel_slider.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProductCarousel extends StatelessWidget {
  const ProductCarousel({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
        builder: (context,productProvider,child) {
          List<Container>? generateImageTiles() {
            return productProvider.selectedProduct!.productImageGallery?.map(
                  (products) => Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(10),
                  color: ColourScheme.overlayColor,
                  image: DecorationImage(image: NetworkImage(products),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),
                        BlendMode.dstATop),)
              )),).toList();
          }
          var imageSliders = generateImageTiles();
          return Stack(
            children: [
              CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                  )
              ),
              Offstage(
                  offstage: !productProvider.isLoading,
                  child: const AppThemedLoader())
            ],
          );
        }
    );
  }
}
