import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicue/widgets/dbox.dart';

class PlayListCard extends StatelessWidget {
  const PlayListCard({super.key, required Image, required name});

  @override
  Widget build(BuildContext context) {
    final Image;
    final name;
    return dbox(
        Child: Container(
      height: 200,
      width: 150,
    ));
  }
}

Widget customPlayListCard(
    {required String libraryname, required String image}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: 90,
        height: 90,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/img demo 1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Text(libraryname)
    ],
  );
}
