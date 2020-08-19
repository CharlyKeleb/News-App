import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDisplay extends StatefulWidget {
  final String url;

  WebDisplay(this.url);

  @override
  _WebDisplayState createState() => _WebDisplayState();
}

class _WebDisplayState extends State<WebDisplay> {
  final _key = UniqueKey();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  // var _isLoading;

  @override
  void initState() {
    super.initState();
//    _isLoading = true;
  }

  num position = 1;

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: IndexedStack(
        index: position,
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.url,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
