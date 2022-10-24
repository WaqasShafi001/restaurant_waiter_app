// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:restaurant_app/common/appColors.dart';
import 'package:restaurant_app/common/capitilizeExtention.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/mealTabs/breakfastTabView.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/mealTabs/dinnerTabView.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/mealTabs/lunchTabView.dart';
import 'package:restaurant_app/flow/menu/views/horizontalLayout/scrollableListTabView/model/scrollable_list_tab.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../widgets/discountOffersWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

const Duration kScrollDuration = const Duration(milliseconds: 150);

class ScrollableListTabView extends StatefulWidget {
  final List<ScrollableListTab>? tabs;
  final int? totalLentgh;
  final TextStyle? style;
  final Duration? tabAnimationDuration;
  final Duration? bodyAnimationDuration;
  final Curve? tabAnimationCurve;
  final Curve? bodyAnimationCurve;
  final double? tabHeight;
  final Color? tabBackgroundColor;
  final double? selectedtabHeight;
  final double? unselectedTabHeight;
  final double? selectedTabWidth;
  final double? unSelectedTabWidth;
  final Color? labelBottomLineColor;
  final String? categoryLabel;
  final String? categoryDescription;
  final ScrollPhysics? bodyScrollPhysics;
  const ScrollableListTabView({
    Key? key,
    this.tabs,
    this.style = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    this.tabAnimationDuration = kScrollDuration,
    this.bodyAnimationDuration = kScrollDuration,
    this.tabAnimationCurve = Curves.decelerate,
    this.bodyAnimationCurve = Curves.decelerate,
    this.tabHeight,
    this.tabBackgroundColor,
    this.selectedtabHeight,
    this.unselectedTabHeight,
    this.selectedTabWidth,
    this.unSelectedTabWidth,
    this.labelBottomLineColor,
    this.categoryLabel,
    this.categoryDescription,
    this.bodyScrollPhysics,
    this.totalLentgh,
  }) : super(key: key);

  @override
  State<ScrollableListTabView> createState() => _ScrollableListTabViewState();
}

class _ScrollableListTabViewState extends State<ScrollableListTabView> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  final ItemScrollController _bodyScrollController = ItemScrollController();
  final ItemPositionsListener _bodyPositionListener =
      ItemPositionsListener.create();
  final ItemScrollController _tabScrollController = ItemScrollController();

  int selectedIndexIs = 0;

  @override
  void initState() {
    super.initState();
    _bodyPositionListener.itemPositions.addListener((_onInnerViewScrolled));
  }

  void _onInnerViewScrolled() async {
    final positions = _bodyPositionListener.itemPositions.value;
    if (positions.isEmpty) return;
    final firstIndex = positions.elementAt(0).index;
    if (_index.value == firstIndex) return;

    await _handleTabScroll(firstIndex);
  }

  Future<void> _handleTabScroll(int index) async {
    _index.value = index;
    await _tabScrollController.scrollTo(
      index: _index.value,
      duration: widget.tabAnimationDuration!,
      curve: widget.tabAnimationCurve!,
    );
  }

  void _onTabPressed(int index) async {
    _tabScrollController.scrollTo(
      index: index,
      duration: widget.tabAnimationDuration!,
      curve: widget.tabAnimationCurve!,
    );
    await _bodyScrollController.scrollTo(
      index: index,
      duration: widget.bodyAnimationDuration!,
      curve: widget.bodyAnimationCurve!,
    );
    _index.value = index;
  }

  @override
  void dispose() {
    _bodyPositionListener.itemPositions.removeListener((_onInnerViewScrolled));
    super.dispose();
  }

  // bool isHide = false;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    _bodyPositionListener.itemPositions.addListener(() {
      if (_bodyPositionListener.itemPositions.value.first.index == 0) {
        setState(() {
          // isHide = true;
          isVisible = true;
        });
      } else {
        setState(() {
          // isHide = false;
          isVisible = false;
        });
      }
    });

    return Column(
      children: [
        FadeInDown(
          duration: Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: Duration(microseconds: 300),
            child: DiscountOffersWidget(
              height: isVisible
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              isVisible: isVisible,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        FlutterToggleTab(
          // width in percent, to set full width just set to 100
          width: 90,
          borderRadius: 30,
          marginSelected: EdgeInsets.all(6),
          height: MediaQuery.of(context).size.height * 0.05,
          isScroll: true,

          selectedBackgroundColors: [AppColors.mainColor],
          unSelectedBackgroundColors: [
            AppColors.textfieldBgColor,
          ],
          selectedTextStyle: TextStyle(
              color: AppColors.pureWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
          unSelectedTextStyle: TextStyle(
              color: AppColors.darkGrayColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          labels: ["All Menu", "Breakfast", "Lunch", "Dinner"],
          selectedIndex: selectedIndexIs,
          selectedLabelIndex: (index) {
            // print("Selected Index $index");
            setState(() {
              selectedIndexIs = index;
              print("Selected Index $selectedIndexIs");
            });
          },
        ),
        selectedIndexIs == 0
            ? Expanded(
                child: Column(
                  children: [
                    widget.totalLentgh == 0
                        ? SizedBox()
                        : FadeInRight(
                            duration: Duration(milliseconds: 700),
                            child: Container(
                              height: widget.tabHeight!,
                              color: widget.tabBackgroundColor!,
                              margin: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width,
                              child: ScrollablePositionedList.builder(
                                itemCount: widget.tabs!.length,
                                initialAlignment: 0,

                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),
                                initialScrollIndex: 0,
                                shrinkWrap: true,
                                // itemPositionsListener: ItemPositionsListener.create(),
                                itemScrollController: _tabScrollController,
                                itemBuilder: (context, index) {
                                  final tab = widget.tabs![index].tab;
                                  return ValueListenableBuilder<int>(
                                    valueListenable: _index,
                                    builder: (_, i, __) {
                                      final selected = index == i;
                                      return InkWell(
                                        onTap: () => _onTabPressed(index),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: selected
                                                  ? widget.selectedtabHeight
                                                  : widget.unselectedTabHeight,
                                              width: selected
                                                  ? widget.selectedTabWidth
                                                  : widget.unSelectedTabWidth,
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                    Colors.black
                                                        .withOpacity(0.9)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: [0, 0.2, 1],
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: tab!.imagePath!,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Image.asset(
                                                      'assets/no_image.png',
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                    child: Image.asset(
                                                      'assets/no_image.png',
                                                    ),
                                                  ),
                                                ),
                                                // Image.network(
                                                //   tab!.imagePath!,
                                                //   fit: BoxFit.fill,
                                                // ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 13,
                                              ),
                                              child: Text(
                                                tab.label!
                                                    .capitalizeFirstofEach,
                                                style: widget.style,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 13, top: 2),
                                              child: Container(
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                color:
                                                    widget.labelBottomLineColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.red,
                                      height: 100,
                                      width: 150,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    widget.totalLentgh == 0
                        ? Expanded(
                            child: Container(
                            child: Center(
                              child: Text(
                                'No Horizontal Porduct Listing',
                              ),
                            ),
                          ))
                        : Expanded(
                            child: FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: ScrollablePositionedList.builder(
                                itemCount: widget.tabs!.length,
                                itemPositionsListener: _bodyPositionListener,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                initialAlignment: 0,
                                initialScrollIndex: 0,
                                itemScrollController: _bodyScrollController,
                                itemBuilder: (_, index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.tabs![index].tab!.label!
                                          .capitalizeFirstofEach,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(_).size.width > 600
                                                ? MediaQuery.of(_).size.height *
                                                    0.014
                                                : MediaQuery.of(_).size.height *
                                                    0.013,
                                      ),
                                    ),
                                    Text(
                                      widget.tabs![index].tab!.slogan!
                                          .capitalizeFirstofEach,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            MediaQuery.of(_).size.width > 600
                                                ? MediaQuery.of(_).size.height *
                                                    0.0145
                                                : MediaQuery.of(_).size.height *
                                                    0.013,
                                        color: AppColors.lightGrayColor,
                                      ),
                                    ),
                                    Flexible(child: widget.tabs![index].body!),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )
            : selectedIndexIs == 1
                ? Expanded(child: BreakfastTabView(menuType: '1'))
                : selectedIndexIs == 2
                    ? Expanded(
                        child: LunchTabView(
                          menuType: '2',
                        ),
                      )
                    : selectedIndexIs == 3
                        ? Expanded(
                            child: DinnerTabView(
                              menuType: '3',
                            ),
                          )
                        : SizedBox(),
      ],
    );
  }
}
