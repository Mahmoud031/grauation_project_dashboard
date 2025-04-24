import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grauation_project_dashboard/core/utils/app_text_styles.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF071A26),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF071A26),
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyles.textstyle25.copyWith(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                            Text(
                              'admin@gmail.com',
                              style: TextStyles.textstyle18.copyWith(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.09,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.white24,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  DrawerItem(
                    icon: FontAwesomeIcons.users,
                    title: 'Manage Members',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  DrawerItem(
                    icon: FontAwesomeIcons.handshakeAngle,
                    title: 'Manage Ngos',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  DrawerItem(
                    icon: FontAwesomeIcons.circleCheck,
                    title: 'Manage Approval',
                    onTap: () {},
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  DrawerItem(
                    icon: FontAwesomeIcons.chartBar,
                    title: 'Reporting',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyles.textstyle25.copyWith(
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
