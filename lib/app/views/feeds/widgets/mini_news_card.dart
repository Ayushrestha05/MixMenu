import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class MiniNewsCard extends StatelessWidget {
  final RssItem news;

  MiniNewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // OnTap go to News Window
        if (news.link != null && (news.link ?? '').isNotEmpty) {
          launchUrl(Uri.parse(news.link!));
        } else {
          showDialog<void>(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('Info'),
                    content: const Text('This feed had no link.'),
                  ));
        }
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        // padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(233, 233, 233, 1),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            buildNewsImageContainer(news),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    news.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  news.pubDate != null && (news.pubDate ?? '').isNotEmpty
                      ? SizedBox(
                          height: 5.0,
                        )
                      : SizedBox(),
                  news.pubDate != null && (news.pubDate ?? '').isNotEmpty
                      ? Text(
                          (news.pubDate!.split(' ').take(4).toList()
                                ..removeRange(0, 1))
                              .join(' '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromRGBO(139, 144, 165, 1),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNewsImageContainer(RssItem news) {
    Widget placeholderWidget = Container(
      // height: 125,
      width: 125,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(233, 233, 233, 1),
        ),
        // borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Icon(Icons.image),
      ),
    );

    if (news.content != null) {
      if (news.content!.images.isNotEmpty) {
        return CachedNetworkImage(
          imageUrl: news.content!.images.first,
          placeholder: (ctx, url) => placeholderWidget,
          errorWidget: (ctx, err, _) {
            log(err);
            return placeholderWidget;
          },
          imageBuilder: (ctx, provider) => Container(
            width: 125,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 1),
                ),
                image: DecorationImage(image: provider, fit: BoxFit.cover)),
          ),
        );
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }
}
