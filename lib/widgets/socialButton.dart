// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/appColors.dart';

class SocialButton extends StatelessWidget {
  final String? imagePath;
  final BoxConstraints? constraints;
  final String? url;
  final String? qrImagepath;

  const SocialButton({
    Key? key,
    this.imagePath,
    this.constraints,
    this.url = 'https://google.com/',
    this.qrImagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          child: Container(
            color: AppColors.darkGrayColor,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                    builder: (c) {
                      return Container(
                        color: AppColors.backgroundColor,
                        height: constraints!.maxHeight * 0.25,
                        width: constraints!.maxWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                height: constraints!.maxHeight * 0.04,
                                width: constraints!.maxWidth * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: AppColors.mainColor.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    url!,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0175
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 7,
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: qrImagepath!,
                                  fit: BoxFit.contain,
                                  height: constraints!.maxHeight,
                                  width: constraints!.maxWidth,
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
                          ],
                        ),
                      );
                    });
              },
              icon: CachedNetworkImage(
                imageUrl: imagePath!,
                fit: BoxFit.fill,
                height: constraints!.maxHeight,
                width: constraints!.maxWidth,
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
              //  Image.asset(
              //   imagePath!,
              //   color: AppColors.pureWhiteColor,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
