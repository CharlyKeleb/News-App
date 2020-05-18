import 'package:flutter/material.dart';
import 'package:news_app/text_to_speech/player.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDescription extends StatelessWidget {
  final journal;

  NewsDescription({this.journal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.6,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(journal.urlToImage),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 1,
                  left: 1,
                  child: IconButton(
                      iconSize: 35,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                      child: Text(journal.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                      child: Text(
                        journal.content,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  //  PlayerWidget(body: journal.content),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text('To Continue Reading, Visit'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: GestureDetector(
                              onTap: () {
                                launchUrl();
                              },
                              child: Text(
                                journal.url,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  launchUrl() async {
    String url = journal.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to Launch $url';
    }
  }
}
