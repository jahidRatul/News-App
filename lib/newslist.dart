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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'All NEWS',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
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
                newsWebsite:
                    'https://bangla.bdnews24.com/?widgetName=rssfeed&widgetId=1151&getXmlFeed=true',
                newsImgName: 'bdnews24.jpg',
              ),
              NewsListWidget(
                newsImgName: 'bbcBangla.png',
                newsWebsite: 'http://feeds.bbci.co.uk/bengali/rss.xml',
              ),
              NewsListWidget(
                newsWebsite: 'https://www.deshebideshe.com/rssfeed/rss/general',
                newsImgName: 'desheBideshe.jpg',
              ),
              NewsListWidget(
                newsWebsite: 'http://www.banglatribune.com/feed/',
                newsImgName: 'banglaTri.png',
              ),
              NewsListWidget(
                newsWebsite: 'http://banglalive.com/feed/',
                newsImgName: 'banglalive.png',
              ),
              NewsListWidget(
                newsWebsite: 'http://www.sangbadpratidin.in/feed/',
                newsImgName: 'sangbadPratidin.png',
              ),
              NewsListWidget(
                newsWebsite:
                    'http://eisamay.indiatimes.com/rssfeedstopstories.cms',
                newsImgName: 'eisomoy.jpg',
              ),
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
