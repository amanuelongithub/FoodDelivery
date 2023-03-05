import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabWidget extends StatefulWidget {
  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int _selectedPage = 0;
  late PageController _pageController;

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 45,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              TabButton(
                text: "Running",
                pageNumber: 0,
                selectedPage: _selectedPage,
                onPressed: () {
                  _changePage(0);
                },
              ),
              TabButton(
                text: "History",
                pageNumber: 1,
                selectedPage: _selectedPage,
                onPressed: () {
                  _changePage(1);
                },
              ),
             ],
          ),
        ),
        Expanded(
          child: PageView(
            onPageChanged: (int page) {
              setState(() {
                _selectedPage = page;
              });
            },
            controller: _pageController,
            children: const [
              Center(
                child: Text('0'),
              ),
              Center(
                child: Text('1'),
              ),
             
              
            ],
          ),
        )
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final VoidCallback onPressed;

  const TabButton(
      {Key? key,
      required this.text,
      required this.selectedPage,
      required this.pageNumber,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? Color.fromARGB(171, 255, 192, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 12.0 : 0,
            horizontal: selectedPage == pageNumber ? 20.0 : 0),
        margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 12.0,
            horizontal: selectedPage == pageNumber ? 0 : 20.0),
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Text(
          text,
          style: TextStyle(
              color: selectedPage == pageNumber
                  ? Colors.white
                  : Color.fromARGB(190, 20, 174, 128)),
        ),
      ),
    );
  }
}
