import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/presentation/profile/widgets/establishment__banner.dart';
import 'package:quickdrop_sellers/src/presentation/profile/widgets/profile_header.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileHeader(),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 140,
            child: EstablishmentBanner(),
          ),
        ],
      ),
    );
  }
}
