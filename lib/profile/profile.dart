import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:love_found_it/profile/service/profile.service.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/profile.dart';

class ProfilePageFull extends StatefulWidget {
  final String? uuid;

  const ProfilePageFull({this.uuid, Key? key}) : super(key: key);

  @override
  _ProfilePageFullState createState() => _ProfilePageFullState();
}

class _ProfilePageFullState extends State<ProfilePageFull> {
  final double coverHeight = 300;
  final double profileHeight = 150;

  Profile profile = Profile();

  // TODO: Replace this with shared preferences
  bool isOwnProfile() => widget.uuid != null;

  @override
  void initState() {
    super.initState();
    if (widget.uuid != null) {
      ProfileService.queryProfile(widget.uuid!).then((value) => {
            if (value == null)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error profile not found"),
                ))
              }
            else
              {
                setState(() {
                  profile = value;
                })
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: isOwnProfile() ? buildEditButton() : null),
          ],
        ),
        body: ListView(
            padding: EdgeInsets.zero,
            children: [buildHeader(), buildContent()]));
  }

  GestureDetector buildEditButton() {
    return GestureDetector(
      onTap: () {},
      child: const Icon(Icons.edit),
    );
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
            profile.cover != null
                ? profile.cover!
                : "https://dummyimage.com/600x400/000/fff&text=+",
            width: double.infinity,
            height: coverHeight,
            fit: BoxFit.cover),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
          profile.photo != null
              ? profile.photo!
              : "https://dummyimage.com/600x400/fff/fff&text=+",
        ),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Text(profile.name != null ? profile.name! : "Loading...",
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            buildSocialIcon(FontAwesomeIcons.instagram, profile.instagram),
            const SizedBox(width: 12),
            buildSocialIcon(FontAwesomeIcons.twitter, profile.twitter),
            const SizedBox(width: 12),
            buildPhoneIcon(profile.phoneNumber),
            const SizedBox(width: 12)
          ]),
          const Divider(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("About",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(
                    profile.biography != null
                        ? profile.biography!
                        : "Loading...",
                    style: const TextStyle(fontSize: 16, color: Colors.black))
              ],
            ),
          )
        ],
      );

  Widget buildSocialIcon(IconData icon, String? link) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                if (link != null) {
                  _launchURL(link);
                }
              },
              child: Center(child: Icon(icon, size: 32))),
        ),
      );

  Widget buildPhoneIcon(String? link) {
    if (link != null) {
      return buildSocialIcon(FontAwesomeIcons.phone, "tel:" + link);
    } else {
      return buildSocialIcon(FontAwesomeIcons.phone, "");
    }
  }

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
