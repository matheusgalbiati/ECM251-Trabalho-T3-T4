import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    'https://cdn.blenner.net/app/clickwallpapers/clickwallpapers-the-last-of-us-2-download-wallpapers-scaled.jpeg',
    'https://superhqwallpapers.com/wp-content/uploads/2021/08/Blue-Dress-Kylian-Mbappe-4k-Hd-Fifa-22-HD-Wallpaper-scaled.jpg',
    'https://www.hardware.com.br/filters:format:(png)/@/static/wp/2021/09/10/imagem_2021-09-09_183119.png',
    'https://manualdosgames.com/wp-content/uploads/2021/07/Forza-Horizon-5.jpg',
    'https://i.imgur.com/7G02Z6X.png'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: urlImages.length,
              options: CarouselOptions(
                  height: size.height * 0.42,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];

                return buildImage(urlImage, index);
              },
            ),
            const SizedBox(height: 32.0),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () {},
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      onDotClicked: animateToSlide,
      effect: const ScrollingDotsEffect(
        dotWidth: 10.0,
        dotHeight: 10.0,
        activeDotColor: Color(0xFF4DCBA1),
        dotColor: Colors.grey,
      ),
    );
  }

  animateToSlide(int index) => controller.animateToPage(index);
}
