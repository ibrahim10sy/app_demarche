import 'package:carousel_slider/carousel_slider.dart';
import 'package:demarche_app/model/Utilisateur.dart';
import 'package:demarche_app/provider/utilisateurProvider.dart';
import 'package:demarche_app/screen/guide_screen.dart';
import 'package:demarche_app/screen/profil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselLoading extends StatefulWidget {
  const CarouselLoading({super.key});

  @override
  State<CarouselLoading> createState() => _CarouselLoadingState();
}

const d_red = Color.fromRGBO(28, 36, 129, 10);

class _CarouselLoadingState extends State<CarouselLoading> {
  List imageList = [
    {"id": 1, "image_path": 'assets/images/mali.jpg'},
    {"id": 2, "image_path": 'assets/images/orange1.png'},
    {
      "id": 3,
      "image_path": 'assets/images/tas-bitcoins-au-dessus-billets-dollars.jpg'
    }
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  late Utilisateur utilisateur;

  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    debugPrint("user recuperation : $utilisateur");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          const Divider(
            height: 2,
            color: d_red,
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
                          .map((item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ))
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          currentIndex = index;
                        },
                      ),
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
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Container(
                        width: currentIndex == entry.key ? 17 : 7,
                        height: 7.0,
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              currentIndex == entry.key ? Colors.grey : d_red,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const GuideScreen()
        ],
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<UtilisateurProvider>(
                  builder: (context, utilisateurprovider, child) {
                    final user = utilisateurprovider.utilisateur;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profil()),
                        );
                      },
                      child: Row(
                        children: [
                          user?.image == null || user?.image?.isEmpty == true
                              ? CircleAvatar(
                                  backgroundColor: d_red,
                                  radius: 28,
                                  child: Text(
                                    "${user!.prenom.substring(0, 1).toUpperCase()}${user.nom.substring(0, 1).toUpperCase()}",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "http://10.0.2.2/${user!.image!}"),
                                  radius: 28,
                                ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Text(
                              "${user.prenom.toUpperCase()} ${user.nom.toUpperCase()} ",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.circle_notifications_sharp,
                    color: d_red,
                    size: 40.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SearchAnchor(
                viewHintText: 'Rechercher ...',
                isFullScreen: false,
                viewElevation: 150,
                dividerColor: d_red,
                viewConstraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                builder: (BuildContext context, SearchController controller) {
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
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      ),
                    ],
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
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
            height: 15,
          ),
        ],
      ),
    );
  }
}
