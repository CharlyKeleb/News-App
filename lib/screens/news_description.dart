import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDescription extends StatefulWidget {
  final journal;

  NewsDescription({this.journal});

  @override
  _NewsDescriptionState createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying;

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(widget.journal.content);
      setState(() {
        isPlaying = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(widget.journal.urlToImage),
                          fit: BoxFit.cover),
                    ),
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
                      child: Text(widget.journal.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                      child: Text(
                        widget.journal.content,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.play_arrow),
                            iconSize: 30,
                            onPressed: () => _speak()),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TyperAnimatedTextKit(
                              onTap: () {
                              },
                              text: [
                                "Tap The Button To Speak",
                              ],
                              textStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: "Bobbers"
                              ),
                              textAlign: TextAlign.center,
                              alignment: AlignmentDirectional.center // or Alignment.topLeft
                          ),
                        ),
                      ],
                    ),
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
                                widget.journal.url,
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
    String url = widget.journal.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to Launch $url';
    }
  }
}
