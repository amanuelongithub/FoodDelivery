import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/components/checkout.dart';
import 'package:fooddelivery/screen/cart_screen.dart';
import 'package:fooddelivery/service/firestore.dart';
import 'package:fooddelivery/utils/utils.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../utils/colors.dart';

class CartCard extends StatefulWidget {
  final snap;
  const CartCard({Key? key, this.snap}) : super(key: key);

  @override
  State<CartCard> createState() => CartCardState();
}

class CartCardState extends State<CartCard> {
  String qunt = '';
  bool check = false;
  final List<String> items = [];

  var _popupMenuItemIndex = 0;

  var appBarHeight = AppBar().preferredSize.height;

  Future<String> setQuantitiy(
      context, bool isIncrement, int quantity, String postId) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      if (isIncrement) {
        print('Hello Four ');

        if (quantity > 6) {
          quantity = 7;
        } else {
          await _firestore
              .collection('user')
              .doc(_auth.currentUser!.uid)
              .collection('cart')
              .doc(postId)
              .update({
            'quantity': FieldValue.increment(1),
          });
          quantity += quantity;
        }
      } else if (!isIncrement) {
        if (quantity < 2) {
          quantity = 1;
        } else {
          await _firestore
              .collection('user')
              .doc(_auth.currentUser!.uid)
              .collection('cart')
              .doc(postId)
              .update({
            'quantity': FieldValue.increment(-1),
          });
          quantity -= quantity;
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return quantity.toString();
  }

  _onMenuItemSelected(int value, String postId) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == 0) {
      FireStoreMethods().removeCart(postId);
    } else if (value == 1) {}
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            iconData,
            size: 18,
            color: AppColors.maincolor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    return Padding(
      padding: EdgeInsets.only(bottom: 25),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              isDark == "dark" ? Color.fromARGB(221, 49, 49, 49) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDark == "dark"
                  ? Color.fromARGB(137, 89, 89, 89)
                  : Colors.grey.withOpacity(0.4),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.all(7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: widget.snap['photoUrl'],
                  errorWidget: (context, url, error) => const SizedBox(
                    height: double.infinity,
                    child: Center(
                        child: Text('!', style: TextStyle(color: Colors.red))),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap['title'],
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.height <= 825 ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.maincolor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.snap['content'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.snap['unitprice'].toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //  onPressed: () {
                //  splashRadius: 20,
                // splashColor: Color.fromARGB(122, 255, 193, 7),

                PopupMenuButton(
                  onSelected: (value) {
                    _onMenuItemSelected(
                        value as int, widget.snap['postId'] as String);
                  },
                  offset: Offset(0.0, appBarHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  itemBuilder: (ctx) => [
                    _buildPopupMenuItem(
                        'Remove from Cart', Icons.delete_forever, 0),
                    _buildPopupMenuItem(
                        'Check out this', FontAwesomeIcons.bagShopping, 1),
                  ],

                  icon: Icon(
                    FontAwesomeIcons.caretDown,
                    color: AppColors.maincolor,
                  ),
                ),

                // icon: Icon(
                //   Icons.more_vert_sharp,
                //   color: AppColors.maincolor,
                // )),
                // Checkbox(
                //     value: check,
                //     checkColor: Colors.black,
                //     fillColor: MaterialStateProperty.all(Colors.amber),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(9), // <-- Radius
                //     ),
                //     onChanged: (value) {
                //       setState(() {
                //         this.check = value!;
                //         if (value == true) {
                //           items.add(widget.snap['cartId']);
                //         } else if (value == false) {
                //           items.removeWhere(
                //               (element) => element == widget.snap['cartId']);
                //         }
                //       });
                //       TopNavBar(items: items);

                //       // additems(value!, widget.snap['cartId']);
                //     }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.minus,
                        size: 25,
                      ),
                      splashColor: Color.fromARGB(131, 255, 193, 7),
                      splashRadius: 25,
                      onPressed: () async {
                        setQuantitiy(context, false, widget.snap['quantity'],
                            widget.snap['postId']);
                      },
                      color: isDark == "dark" ? Colors.white : Colors.black54,
                    ),
                    SizedBox(width: 1),
                    Center(
                        child: Text(
                      widget.snap['quantity'].toString(),
                      style: TextStyle(fontSize: 20),
                    )),
                    SizedBox(width: 1),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 30,
                      ),
                      splashColor: Color.fromARGB(131, 255, 193, 7),
                      splashRadius: 25,
                      onPressed: () async {
                        await setQuantitiy(context, true,
                            widget.snap['quantity'], widget.snap['postId']);
                      },
                      color: isDark == "dark" ? Colors.white : Colors.black54,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
