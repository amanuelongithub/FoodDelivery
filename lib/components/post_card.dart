import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/utils/fade_animation.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../screen/detaile_screen.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    return FadeAnimation(
      firstanim,
      Container(
        width: double.maxFinite,
        height: 300,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: isDark == "dark"
                    ? Color.fromARGB(137, 89, 89, 89)
                    : Colors.grey.withOpacity(0.4),
                offset: const Offset(10, 10),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Get.to(() => DetailPage(
                    title: widget.snap['title'],
                    content: widget.snap['content'],
                    description: widget.snap['description'],
                    price: widget.snap['price'],
                    postId: widget.snap['postId'],
                    photoUrl: widget.snap['postUrl'],
                  )),
              child: Hero(
                tag: widget.snap['postId'],
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: CachedNetworkImage(
                        imageUrl: widget.snap['postUrl'],
                        fit: BoxFit.contain,
                        width: double.maxFinite,
                        height: 220,
                        errorWidget: (context, url, error) => SizedBox(
                          height: double.infinity,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                      text: '!',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red)),
                                  TextSpan(
                                      text: 'Unable to load image',
                                      style: TextStyle(
                                        color: isDark == "dark"
                                            ? Colors.white
                                            : Color.fromARGB(221, 49, 49, 49),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              )),
          const Divider(
            color: Color.fromARGB(214, 133, 133, 133),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['title'],
                          style: TextStyle(
                            color: AppColors.maincolor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.snap['content'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_rounded,
                            color: AppColors.maincolor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '35 min',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: AppColors.maincolor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            widget.snap['price'],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
