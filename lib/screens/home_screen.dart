import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/news_description.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading;
  var newslist;

  void getNews() async {
    News news = News();
    await news.getNews();
    setState(() {
      loading = false;
      newslist = news.news;
    });
  }

  @override
  void initState() {
    loading = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Center(
          child: Text('Wall Street Journal'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: loading
              ? JumpingDotsProgressIndicator(
                  fontSize: 40,
                  color: Colors.grey,
                )
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Text(
                            'Top Headlines',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: newslist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                child: ListTile(
                                  title: Text(
                                    newslist[index].title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(DateFormat.Hm()
                                      .format(newslist[index].publishedAt)),
                                  leading: Container(
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            newslist[index].urlToImage),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => NewsDescription(
                                            journal: newslist[index],
                                          )));
                                },
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
