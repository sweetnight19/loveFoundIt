import 'package:flutter/material.dart';
import 'package:love_found_it/home/list_friends.dart';
import 'package:love_found_it/profile/profile.dart';

class HomeFull extends StatefulWidget {
  const HomeFull({Key? key}) : super(key: key);

  @override
  _HomeFullState createState() => _HomeFullState();
}

class _HomeFullState extends State<HomeFull> {
  int _paginaActual = 0;

  final List<Widget> _paginas = [
    const ListFull(),
    const ProfilePageFull(
      uuid: "8NGvV65Z3TMv6y0xLa512tiOtm53",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedItemColor: Colors.pink[500],
          onTap: (value) {
            setState(() {
              _paginaActual = value;
            });
          },
          currentIndex: _paginaActual,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.pink),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: 'Perfil'),
          ]),
    );
  }
}
