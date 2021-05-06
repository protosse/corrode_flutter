import 'package:corrode/models/book.dart';
import 'package:corrode/theme/colors.dart';
import 'package:corrode/util/constants/images.dart';
import 'package:corrode/util/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final Book model;

  BookListItem({this.model});

  @override
  Widget build(BuildContext context) {
    var viewString = "";
    if (model.views > 10000) {
      viewString = "${(model.views / 10000).toStringAsFixed(1)}万人阅读";
    } else {
      viewString = "${model.views}人阅读";
    }
    return Container(
      height: 115,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: FadeInImage(
              width: 85,
              fit: BoxFit.cover,
              placeholder: Images.placeholder,
              image: NetworkImage(model.cover),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 15)),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: TextStyle(fontSize: 14, color: Colours.text_dark),
                ),
                Text(
                  model.description,
                  maxLines: 3,
                  style: TextStyle(fontSize: 12, color: Colours.text_gray),
                ),
                Spacer(),
                Row(
                  children: [
                    _tags(context),
                    Spacer(),
                    Text(
                      viewString,
                      style: TextStyle(fontSize: 12, color: Colours.app_main),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tags(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: model.tag
          .map((e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                e.tab,
                style: TextStyle(
                  fontSize: 10,
                  color: HexColor.fromHex(e.color),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colours.divider)))
          .toList(),
    );
  }
}
