import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicue/widgets/dbox.dart';

class CustomPlaylistCard extends StatelessWidget {
  const CustomPlaylistCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      height: screenHeight * 0.19,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            // width: 120,
            width: screenWidth * 0.33,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/images/img demo 3.jpg',
                fit: BoxFit.cover,
                // height: 137,
                height: screenHeight * 0.21,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 14),
            // width: 120,
            width: screenWidth * 0.33,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/images/img demo 1.jpg',
                fit: BoxFit.cover,
                // height: 137,
                height: screenHeight * 0.21,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 14),
            // width: 120,
            width: screenWidth * 0.33,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/images/img demo 2.jpg',
                fit: BoxFit.cover,
                // height: 137,
                height: screenHeight * 0.21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget customCard1({required String libraryname}) {
  return Column(
    children: [
      InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), boxShadow: []),
          width: 133,
          height: 152,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/sample image.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(libraryname),
      )
    ],
  );
}

Widget customCard2({required String libraryname}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), boxShadow: []),
        width: 133,
        height: 152,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/sample 8.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(libraryname),
      )
    ],
  );
}

Widget customCard3({required String libraryname}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), boxShadow: []),
        width: 133,
        height: 152,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/sample image 11.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(libraryname),
      )
    ],
  );
}
