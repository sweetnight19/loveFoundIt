import 'package:flutter/material.dart';
import 'package:love_found_it/home/list_friends.dart';

class HomeLess extends StatelessWidget {
  const HomeLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeFull(),
    );
  }
}

class HomeFull extends StatefulWidget {
  const HomeFull({Key? key}) : super(key: key);

  @override
  _HomeFullState createState() => _HomeFullState();
}

class _HomeFullState extends State<HomeFull> {
  int _paginaActual = 0;

  final List<Widget> _paginas = [
    const ListFull(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'HOME',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
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
