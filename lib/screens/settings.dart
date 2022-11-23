// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:musicue/screens/screensettingsTile.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/navBarFunction.dart';
import 'package:musicue/widgets/settingsListTile.dart';
import 'package:share_plus/share_plus.dart';

const String NOTIFICATION = 'NOTIFICATION';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: CustomnavBarFunction(),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: dbox(
                        Child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios))),
                  ),
                  const Text('S E T T I N G S'),
                  Container(
                    height: 60,
                    width: 60,
                    child: const dbox(Child: Icon(Icons.more_vert)),
                  )
                ],
              ),
              Column(children: [
                SettingListTile(
                    labeltext: 'ABOUT ME',
                    icon: Icons.person,
                    onTap: (() {
                      showAboutMeDialoge(
                          context: context, screenHeight: screenHeight);
                    })),
                const Divider(
                  thickness: 2,
                ),
                SettingListTile(
                  labeltext: 'SHARE',
                  icon: Icons.share,
                  onTap: () async {
                    await Share.share(
                      'Download Musique from Playstore For Free \nWith Musique you can play the device music and get the lyrics of the known artist.Download Now On Playstore',
                    );
                  },
                ),
                const Divider(
                  thickness: 2,
                ),
                SettingListTile(
                  labeltext: 'PRIVACY POLICY',
                  icon: Icons.security_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ScreenSettingTile(screenName: 'Privacy Policy');
                      }),
                    );
                  },
                ),
                const Divider(
                  thickness: 2,
                ),
                SettingListTile(
                  labeltext: 'TERMS & CONDITIIONS',
                  icon: Icons.privacy_tip_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ScreenSettingTile(
                            screenName: 'Terms and Conditions');
                      }),
                    );
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                SettingListTile(
                  labeltext: 'License',
                  icon: Icons.warning,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Theme(
                            data: ThemeData(
                              textTheme: const TextTheme(
                                bodyText2: TextStyle(
                                  color: Colors.blueGrey,
                                  fontFamily: 'Poppins',
                                ),
                                subtitle1: TextStyle(
                                  color: Colors.blueGrey,
                                  fontFamily: 'Poppins',
                                ),
                                caption: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                                headline6: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              cardColor: Colors.grey.shade300,
                              appBarTheme: const AppBarTheme(
                                backgroundColor: Colors.blueGrey,
                                elevation: 0,
                              ),
                            ),
                            child: const LicensePage(
                              applicationName: 'MUSICUE',
                              applicationVersion: '1.0.0',
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const Divider(
                  thickness: 2,
                ),
              ]),
            ],
          ),
        )),
      ),
    );
  }

  showAboutMeDialoge(
      {required BuildContext context, required double screenHeight}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: const [
                    Text(
                      'About Me',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'This App is designed and developed by Mohammed Rajnaz',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
