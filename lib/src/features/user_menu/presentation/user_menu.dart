import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/image_loader.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: Icon(
            HugeIcons.strokeRoundedUserAccount,
            color: Constants.secondaryColor,
          ),
          title: Text(
            'tienda'.capitalize(),
          ),
          automaticallyImplyLeading: false,
        ),
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 80),
            child: Material(
              borderRadius: Constants.mainBorderRadius,
              color: Constants.mainColor,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
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
                          child: const ImageLoader(
                            imageUrl:
                                'https://img.freepik.com/free-photo/colorful-design-with-spiral-design_188544-9588.jpg',
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'company name'.capitalize(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
