import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/flow/menu/views/cart/model/getAllCartModel.dart';
import '../../../../../common/appColors.dart';

class CartSingleItemWidget extends StatefulWidget {
  final BoxConstraints? constraints;
  const CartSingleItemWidget({
    Key? key,
    required this.imagePath,
    this.constraints,
    this.itemTitle,
    this.itemDescription,
    this.itemPrice,
    this.itemQuantity,
    required this.removeItemCall,
    required this.updateItemCall,
    this.extras,
  }) : super(key: key);

  final String? imagePath;
  final String? itemTitle;
  final String? itemDescription;
  final int? itemPrice;
  final int? itemQuantity;
  final Function removeItemCall;
  final Function(int) updateItemCall;
  final List<CartExtras>? extras;

  @override
  State<CartSingleItemWidget> createState() => _CartSingleItemWidgetState();
}

class _CartSingleItemWidgetState extends State<CartSingleItemWidget> {
  int? newQuanity;

  @override
  void initState() {
    newQuanity = widget.itemQuantity;
    super.initState();
  }

  void increamentCounter(int? val) {
    if (val! >= 1) {
      newQuanity = newQuanity! + 1;
    }
  }

  void decreamentCounter(int? val) {
    if (val! > 1) {
      newQuanity = newQuanity! - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.pureWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: widget.constraints!.maxHeight * 0.12,
              width: widget.constraints!.maxWidth * 0.9,
              decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.imagePath ?? '',
                            fit: BoxFit.fill,
                            height: widget.constraints!.maxHeight,
                            width: widget.constraints!.maxWidth,
                            placeholder: (context, url) => Center(
                              child: Image.asset(
                                'assets/no_image.png',
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Image.asset(
                                'assets/no_image.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 7,
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.itemTitle}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  height: widget.constraints!.maxHeight * 0.04,
                                  width: widget.constraints!.maxWidth * 0.22,
                                  child: Container(
                                    color: AppColors.pureWhiteColor,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              decreamentCounter(newQuanity);
                                              setState(() {});
                                            },
                                            child: Container(
                                              // height: MediaQuery.of(context).size.height * 0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.lightGrayColor,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.black2Color,
                                                width: 2,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$newQuanity',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              increamentCounter(newQuanity);
                                              setState(() {});
                                            },
                                            child: Container(
                                              // height: MediaQuery.of(context).size.height * 0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.mainColor,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color:
                                                      AppColors.pureWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: widget.constraints!.maxWidth,
                              child: Text(
                                '${widget.itemDescription}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: widget.constraints!.maxHeight * 0.012,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  color: AppColors.deepPurpleColor
                                      .withOpacity(0.7)),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  '\$ ${widget.itemPrice}',
                                  style: TextStyle(
                                      fontSize: 11, color: AppColors.mainColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: widget.constraints!.maxHeight * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, top: 8),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                log('remove item');
                                widget.removeItemCall();
                              },
                              child: Image.asset(
                                'assets/cross.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // widget.extras!.isEmpty
            //     ? SizedBox()
            //     : Column(
            //         children: [
            //           for (int i = 0; i < widget.extras!.length; i++)
            //             Padding(
            //               padding: const EdgeInsets.all(20.0),
            //               child: ListTile(
            //                 title: Text(widget.extras![i].name!),
            //                 subtitle: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(widget.extras![i].id.toString()),
            //                     Text("price : " +
            //                         widget.extras![i].price.toString()),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //         ],
            //       ),
            Container(
              height: widget.constraints!.maxHeight * 0.015,
              width: widget.constraints!.maxWidth,
              decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            newQuanity != widget.itemQuantity
                ? InkWell(
                    onTap: () {
                      log('item update');
                      widget.updateItemCall(newQuanity!);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: Container(
                        height: widget.constraints!.maxHeight * 0.024,
                        width: widget.constraints!.maxWidth,
                        color: AppColors.mainColor,
                        child: Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: AppColors.pureWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
