import 'package:flutter/material.dart';

class ProfilePageFull extends StatefulWidget {
  const ProfilePageFull({Key? key}) : super(key: key);

  @override
  _ProfilePageFullState createState() => _ProfilePageFullState();
}

class _ProfilePageFullState extends State<ProfilePageFull> {
  final double coverHeight = 300;
  final double profileHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
            padding: EdgeInsets.zero,
            children: [buildHeader(), buildContent()]));
  }

  Stack buildHeader() {
    final double top = coverHeight - profileHeight / 2;
    final double bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(top: top, child: buildProfileImage())
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
            "https://pbs.twimg.com/profile_banners/470216542/1415177925/1500x500",
            width: double.infinity,
            height: coverHeight,
            fit: BoxFit.cover),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const NetworkImage(
          "https://pbs.twimg.com/profile_images/1192158313858969600/rX1SBLkC_400x400.jpg",
        ),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          const Text("Arnau Garcia",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const Divider(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("About", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus aliquam laoreet justo, non semper erat pretium id. Nam id odio ut urna gravida hendrerit. Aliquam pharetra rutrum tellus, quis tincidunt odio tincidunt quis. Curabitur ultrices lobortis aliquam.",
                    style: TextStyle(fontSize: 16, color: Colors.black))
              ],
            ),
          )
        ],
      );
}
