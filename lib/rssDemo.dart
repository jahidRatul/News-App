import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSSDemo extends StatefulWidget {
  final String title = 'Demo Feed Title';
  @override
  _RSSDemoState createState() => _RSSDemoState();
}

class _RSSDemoState extends State<RSSDemo> {
//  static const FEED_URL = 'http://feeds.bbci.co.uk/bengali/rss.xml';
//  static const FEED_URL = 'https://www.nasa.gov/rss/dyn/educationnews.rss';

  static const FEED_URL = 'https://www.prothomalo.com/feed/';

  RssFeed _feed;
  String _title;
  static const String updateFeedMsg = 'Loading feed...';
  static const String feedLoadErrMsg = 'Error Loading Feed';
  static const String placeholderImage = 'images/noimage.png';
  static const String feedOpenErrMsg = 'Error opening Feed';

  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      launch(url, forceSafariVC: false, forceWebView: true);
      return;
    }
    updateTitle(feedOpenErrMsg);
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subTitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imgUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImage),
        imageUrl: imgUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.arrow_right,
      size: 30,
      color: Colors.grey,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return ListTile(
          title: title(item.title),
          subtitle: subTitle(item.pubDate),
          //  leading: thumbnail(item.enclosure.url),
          leading: SizedBox(
            height: 50,
            width: 70,
            child: Image.asset(placeholderImage),
          ),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5),
          onTap: () {
            openFeed(item.link);
          },
        );
      },
    );
  }

  isFeedEmpty() {
    return _feed == null || _feed.items == null;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  load() async {
    updateTitle(updateFeedMsg);
    loadFeed().then((result) {
      if (result == null || result.toString().isEmpty) {
        updateTitle(feedLoadErrMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {}
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: body(),
    );
  }
}
