import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news_app/screens/webview.dart';
//import 'package:url_launcher/url_launcher.dart';

class NewsDescription extends StatefulWidget {
  final journal;

  NewsDescription({this.journal});

  @override
  _NewsDescriptionState createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(widget.journal.description);
      setState(() {
        isPlaying = false;
      });
    }

    Future _stop() async {
      await flutterTts.stop();
      setState(() {
        isPlaying = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            iconSize: 35,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        widget.journal.description,
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
                        isPlaying
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      icon: Icon(Icons.play_arrow),
                                      iconSize: 30,
                                      color: Colors.black,
                                      onPressed: () => _speak(),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      icon: Icon(Icons.pause),
                                      iconSize: 30,
                                      color: Colors.black,
                                      onPressed: () => _stop(),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: isPlaying
                                ? TyperAnimatedTextKit(
                                    onTap: () {},
                                    text: [
                                      "Tap The Button To Speak",
                                    ],
                                    stopPauseOnTap: true,
                                    textStyle: TextStyle(
                                        fontSize: 15.0, fontFamily: "Bobbers"),
                                    textAlign: TextAlign.center,
                                    alignment: AlignmentDirectional
                                        .center // or Alignment.topLeft
                                    )
                                : SizedBox()),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text('To Continue Reading'),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //launchUrl();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WebDisplay(widget.journal.url),
                              ),
                            );
                          },
                          child: Text(
                            'Click',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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

 /* launchUrl() async {
    String url = widget.journal.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Unable to Launch $url';
    }
  } */
}
