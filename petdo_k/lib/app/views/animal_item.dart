import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/const.dart';
import 'my_image.dart';

class AnimalItem extends StatelessWidget {
  final String url;
  final String name;
  final String origin;
  final String temperament;
  final GestureTapCallback? onTap;

  const AnimalItem({
    Key? key,
    required this.url,
    required this.name,
    required this.origin,
    required this.onTap,
    required this.temperament,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [defaultBoxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              child: _image(url),
            ),
            SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Get.textTheme.headline6?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    temperament,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Get.textTheme.bodyText2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: subPrimaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          origin,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Get.textTheme.bodyText1?.copyWith(
                            color: subPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _image(String link) => AspectRatio(
        aspectRatio: 1,
        child: MyImage(link: link),
      );
}
