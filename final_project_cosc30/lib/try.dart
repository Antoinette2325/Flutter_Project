import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Two Rows Carousel Slider'),
      ),
      body: Column(
        children: [
          CarouselRow(rowNumber: 1),
          CarouselRow(rowNumber: 2),
        ],
      ),
    );
  }
}

class CarouselRow extends StatelessWidget {
  final int rowNumber;

  CarouselRow({required this.rowNumber});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: MediaQuery.of(context).size.height *
              0.3, // Adjust the height as needed

          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction:
              0.3 // Adjust the fraction to control the number of visible items
          ),
      items: List.generate(5, (index) {
        return InkWell(
          onTap: () {
            // Navigate to the desired route page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(rowNumber, index),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 8.0),
            height: 15, // Adjust height
            width: 300, // Adjust width
            padding: EdgeInsets.all(8.0), // Adjust padding
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image, // Replace with your portrait content
                  size: 40.0, // Adjust size
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Row $rowNumber, Box $index',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0, // Adjust size
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int rowNumber;
  final int boxIndex;

  DetailPage(this.rowNumber, this.boxIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Text('You tapped on Row $rowNumber, Box $boxIndex'),
      ),
    );
  }
}
