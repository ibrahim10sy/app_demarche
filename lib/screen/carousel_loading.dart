import 'package:carousel_slider/carousel_slider.dart';
import 'package:demarche_app/screen/guide_screen.dart';
import 'package:flutter/material.dart';

class CarouselLoading extends StatefulWidget {
  const CarouselLoading({super.key});

  @override
  State<CarouselLoading> createState() => _CarouselLoadingState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);
bool isDark = false;

class _CarouselLoadingState extends State<CarouselLoading> {
  List imageList = [
    {"id": 1, "image_path": 'assets/images/image15.png'},
    {"id": 2, "image_path": 'assets/images/image16.png'},
    {"id": 3, "image_path": 'assets/images/logo.png'}
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Opacity(
            opacity: 0.9,
            child: Container(
              width: double.infinity,
              height: 155,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 5.0,
                      color: Color.fromRGBO(
                          0, 0, 0, 0.25) //Color.fromRGBO(47, 144, 98, 1)
                      )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: d_red,
                              radius: 25,
                              child: Text(
                                "IS",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Ibrahim SY',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_alert,
                          color: d_red,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SearchAnchor(
                        builder: (BuildContext context,
                            SearchController controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search),
                            trailing: <Widget>[
                              Tooltip(
                                message: 'Entrez un nom',
                                child: IconButton(
                                  isSelected: isDark,
                                  onPressed: () {
                                    setState(() {
                                      isDark = !isDark;
                                    });
                                  },
                                  icon: const Icon(Icons.wb_sunny_outlined),
                                  selectedIcon:
                                      const Icon(Icons.brightness_2_outlined),
                                ),
                              ),
                            ],
                          );
                        },
                        suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
                          return List<ListTile>.generate(3, (int index) {
                            final String item = 'item $index';
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                setState(() {
                                  controller.closeView(item);
                                });
                              },
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  print(currentIndex);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 228, 225, 225),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Image.asset(
                              item['image_path'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            currentIndex = index;
                          }),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      print(entry);
                      print(entry.key);
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          padding: const EdgeInsets.all(160.0),
                          width: currentIndex == entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.grey
                                  : d_red),
                        ),
                      );
                    }).toList(),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20 ,
          ),
          const GuideScreen()
        ],
      ),
    );
  }
}


