import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'rssDemo.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Bangla NEWS';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              NewsListWidget(
                newsImgName: 'prothomalo.jpeg',
                newsWebsite: 'https://www.prothomalo.com/feed/',
              ),
              NewsListWidget(
                newsImgName: 'bbcBangla.png',
                newsWebsite: 'http://feeds.bbci.co.uk/bengali/rss.xml',
              ),
              NewsListWidget(
                newsWebsite: 'https://www.deshebideshe.com/rssfeed/rss/general',
                newsImgName: 'desheBideshe.jpg',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsListWidget extends StatelessWidget {
  NewsListWidget({this.newsImgName, this.newsWebsite});
  final String newsImgName;
  final String newsWebsite;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RSSDemo(
                      newsPortal: newsWebsite,
                      newsImg: newsImgName,
                    )),
          );
        },
        child: Container(
          height: 100,
          child: Container(
            // width: 300,
            padding: EdgeInsets.all(7),
            child: Image.asset(
              'images/$newsImgName',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
