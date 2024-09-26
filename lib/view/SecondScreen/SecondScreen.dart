import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sepatuv5/screens/add_todo_screen.dart';
import 'package:sepatuv5/screens/splash_screen.dart';
import 'package:sepatuv5/view/homeScreen/home_screen.dart';
import 'package:sepatuv5/view/profilPage/profil_page.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              TopBar(),
              SearchInput(),
              PromoCard(),
              Headline(),
              CardListView(),
              SHeadline(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBottomBar(
                    text: "Home",
                    icon: Icons.home,
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                IconBottomBar(
                    text: "catalog",
                    icon: Icons.shopping_bag_outlined,
                    selected: _selectedIndex == 1,
                    onPressed: () {
                      Get.to(());
                    }),
                IconBottomBar(
                    text: "akun ",
                    icon: Icons.account_circle_rounded,
                    selected: _selectedIndex == 2,
                    onPressed: () {
                      Get.to(ProfilePage());
                    }),
                IconBottomBar(
                    text: "FYP",
                    icon: Icons.exit_to_app,
                    selected: _selectedIndex == 3,
                    onPressed: () {
                      Get.to(HomeScreen());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: selected ? const Color(0xff15BE77) : Colors.grey,
          ),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 14,
              height: .1,
              color: selected ? const Color(0xff15BE77) : Colors.grey),
        )
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Find your Style\nYourself",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.25)),
            ]),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 25,
                color: Color(0xff53E88B),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0, bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: TextField(
          onChanged: (value) {
            //Do something wi
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class PromoCard extends StatelessWidget {
  const PromoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 130, 182, 27),
              Color.fromARGB(255, 183, 89, 22)
            ])),
        child: Stack(
          children: [
            Opacity(
              opacity: .29,
              child: Image.network(
                  "https://th.bing.com/th/id/OIP.b-h4amdX-shPeh7sJdV1UQAAAA?w=305&h=181&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                  fit: BoxFit.cover),
            ),
            // Image.network(
            //     "https://th.bing.com/th/id/OIP.9WTF3K6121ANt2U2rA0DjQHaFT?w=258&h=174&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
            // const Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: EdgeInsets.all(0.0),
            //     child: Text(
            //       "Style ?\nmake your\nhapines\n-+_+",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 22,
            //           fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Nearest Local UMKM",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "The best Shoes UMKM to you",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const Text(
            "View More",
            style: TextStyle(
                color: Color(0xff15BE77), fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class SHeadline extends StatelessWidget {
  const SHeadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular Shoes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "The best Shoes for you",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          // Tambahkan widget CardListView di sini
          populer(),
        ],
      ),
    );
  }
}

class CardListView extends StatelessWidget {
  const CardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 175,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Card(
                "Adidas",
                "https://s-media-cache-ak0.pinimg.com/564x/60/ab/a9/60aba961c51b8c5e08d293b2a38a81db.jpg",
                "Adidas Indonesia"),
            Card(
                "Ventello ",
                "https://karirpurwokerto.id/wp-content/uploads/2021/08/Ventela.jpg",
                "Ventello offisial"),
            Card(
                "Sepatu opo i ?",
                "https://th.bing.com/th/id/R.31c872495b4e6b430c56003496649051?rik=yZCLaGavGCyELw&riu=http%3a%2f%2f2.bp.blogspot.com%2f-DKU153JLD7I%2fT8RhVnwtQfI%2fAAAAAAAABmY%2fonyxw5UAoFI%2fs1600%2fLogo_KAI_2011.png&ehk=vdM7AC7YpM2ptd5r6zZRJFIZ25FDWdiURbL0WeSorJU%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1",
                "Rel rusak ?"),
            Card(
                "COmpass",
                "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/mlogo/SEC-70061-c7c4ecdd-16f4-4894-bda4-22904c4c21c3.jpg",
                "Compasss official"),
            Card(
                "Dudukan",
                "https://img2.pngdownload.id/20181116/kgh/kisspng-wash-boots-before-entering-floor-sign-version-1-br-1-kitchen-u-26-food-safety-signs-raw-meat-area-5bef94b09e1089.7611505815424278246474.jpg",
                "Dudukan official"),
          ],
        ),
      ),
    );
  }
}

class populer extends StatelessWidget {
  const populer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, bottom: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 175,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Card(
                "Adadas y7s",
                "https://2.bp.blogspot.com/-Rxf40nxGXKk/W1NuYXdyQrI/AAAAAAAACFA/c7wy5ap_SWw3ItifPkvwdlSU8QplomFWQCEwYBhgL/s1600/sepatu.jpg",
                "Adudas Indonesia"), // Ganti path gambar sesuai dengan struktur proyek Anda
            Card(
                "Pers V.2",
                "https://s1.bukalapak.com/img/1136288811/w-1000/Sepatu_Wanita_Casual_sneakers_Putih__sepatu_Cewek_Main_Gaya_.jpg",
                "Nik Indoneisa"),
            Card(
                "Heelas",
                "https://media.karousell.com/media/photos/products/2015/08/13/sepatu_high_heels_wanita_formal_pantofel_sepatu_kerja_wanitags_5001_1439457035_7e180921.jpg",
                "Libery Official"),
            Card(
                "osiid 1.2",
                "https://s2.bukalapak.com/img/2910932821/large/Sepatu_Basket_Nike_Hyperdunk_2016_HD_16_Low_Grey_ORIGINAL_BN.jpg",
                "Remember Store"),
            Card(
                "Lusuh",
                "https://pict-b.sindonews.net/dyn/620/pena/news/2020/07/21/186/107894/sepatu-ini-sengaja-dirancang-agar-tampak-kotor-fli.jpg",
                "Reget official"),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  Card(this.text, this.imageUrl, this.subtitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 15),
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.network(imageUrl, height: 70, fit: BoxFit.cover),
            Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
