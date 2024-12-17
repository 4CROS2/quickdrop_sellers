import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/image_loader.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        physics: Constants.mainPhysics,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 80),
                  child: Material(
                    borderRadius: Constants.mainBorderRadius,
                    color: Constants.mainColor,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                        context.push('/establishment');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Constants.paddingValue / 2),
                        child: Row(
                          spacing: Constants.paddingValue,
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                              height: double.infinity,
                              child: ClipRRect(
                                borderRadius: Constants.mainBorderRadius / 2,
                                child: ImageLoader(
                                  imageUrl:
                                      'https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg',
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'company name'.capitalize(),
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
