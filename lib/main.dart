

import 'dart:math';
import 'package:protory/gestures.dart';

import 'package:first_flutter_app/bottom_controls.dart';
import 'package:first_flutter_app/songs.dart';
import 'package:first_flutter_app/theam.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sauce Radio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  

  @override
  Widget build(BuildContext context) {
    return new AudioPlaylist(
      playlist: demoPlaylist.songs.map((DemoSong song) {
        return song.audioUrl;
      }).toList(growable: false),
      playbackState: PlaybackState.paused,
          child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
            ),
            color: const Color(0xFFDDDDDD),
            onPressed: (){},
          ),
          title: new Text(''),
          actions: <Widget>[new IconButton(
            icon: new Icon(
              Icons.menu,
            ),
            color: const Color(0xFFDDDDDD),
            onPressed: (){},
          ),],
        ),
        body: new Column(
          children: <Widget>[
            // Seek bar
            new Expanded(
              child: AudioPlaylistComponent(
                playlistBuilder: (BuildContext context, Playlist playlist, Widget child){

                  String albumArtUrl = demoPlaylist.songs[playlist.activeIndex].albumArtUrl;

                  return new AudioRadialSeekBar(
                    albumArtUrl: albumArtUrl,
                  );
                },
              ),
              
            ),

            // Visualizer
            new Container(
              width: double.infinity,
              height: 125.0,
            ),

            // Song title, artist name, controls
            new BottomControls()
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class AudioRadialSeekBar extends StatefulWidget {
  final String albumArtUrl;

  AudioRadialSeekBar({
    this.albumArtUrl,
  });

 

  @override
  AudioRadialSeekBarState createState() {
    return new AudioRadialSeekBarState();
  }
}

class AudioRadialSeekBarState extends State<AudioRadialSeekBar> {

  double _seekPercent;

  @override
  Widget build(BuildContext context) {
    return AudioComponent (
      updateMe: [
        WatchableAudioProperties.audioPlayhead,
        WatchableAudioProperties.audioSeeking,
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child){

        double playbackProgress = 0.0;
        if(player.audioLength != null && player.position != null){
          playbackProgress = player.position.inMilliseconds / player.audioLength.inMilliseconds;
        }

        _seekPercent = player.isSeeking ? _seekPercent : null;

        return new RadialSeekBar(
          progress: playbackProgress,
          seekPercent: _seekPercent,
          onSeekRequested: (double seekPercent){
            setState(() => _seekPercent = seekPercent);

            final seekMillis = (player.audioLength.inMilliseconds * seekPercent).round();
            player.seek(new Duration(milliseconds: seekMillis));
          },
          child: new Container(
            color: accentColor,
            child: new Image.network(
              widget.albumArtUrl,
              fit: BoxFit.cover,
            ),
          )
        );
      },
      
      );
  }
}

class RadialSeekBar extends StatefulWidget {

  final double progress;
  final double seekPercent;
  final Function(double) onSeekRequested;
  final Widget child;

  RadialSeekBar({
    this.progress = 0.0,
    this.seekPercent = 0.0,
    this.onSeekRequested,
    this.child,
  });

  @override
  RadialSeekBarState createState() {
    return new RadialSeekBarState();
  }
}

class RadialSeekBarState extends State<RadialSeekBar> {

  double _progress = 0.0;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _currentDragPercent;

  @override
  void initState(){
    super.initState();
    _progress = widget.progress;
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget){
    super.didUpdateWidget(oldWidget);
    _progress = widget.progress;
  }

  void _onDragStart(PolarCoord coord){

    _startDragCoord = coord;
    _startDragPercent = _progress;
  }

  void _onDragUpdate(PolarCoord coord){
    final dragAngle = coord.angle - _startDragCoord.angle;
    final dragPercent = dragAngle / (2 * pi);

    setState(() => _currentDragPercent = (_startDragPercent + dragPercent) % 1.0);
  }

  void _onDragEnd(){

    if(widget.onSeekRequested != null){
      widget.onSeekRequested(_currentDragPercent);
    }
    setState(() {
          _currentDragPercent = null;
          _startDragCoord = null;
          _startDragPercent = 0.0;
        });
  }

  @override
  Widget build(BuildContext context) {

    double thumbPosition = _progress;
    if(_currentDragPercent != null){
      thumbPosition = _currentDragPercent;
    }else if(widget.seekPercent != null){
      thumbPosition = widget.seekPercent;
    }
    return new RadialDragGestureDetector(
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      onRadialDragEnd: _onDragEnd,
                  child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: new Center(
          child: new Container(
            width: 140.0,
            height: 140.0,
            child: new RadialProgressBar(
              trackColor: const Color(0xFFDDDDDD),
              progressPercent: _progress,
              progressColor: accentColor,
              thumbPosition: thumbPosition,
              thumbColor: lightAccentColor,
              innerPadding: const EdgeInsets.all(10.0),
              outterPadding: const EdgeInsets.all(10.0),
                              child: new ClipOval(
                clipper: new CircleClipper(),
                child: widget.child,
                ),
              ),
            ),
          ),
        ),
      );
  }
}

class RadialProgressBar extends StatefulWidget{

  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final double thumbPosition;
  final EdgeInsets outterPadding;
  final EdgeInsets innerPadding;
  final Widget child;

  RadialProgressBar({
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.progressPercent = 0.0,
    this.thumbSize = 10.0,
    this.thumbColor = Colors.black,
    this.thumbPosition = 0.0,
    this.outterPadding = const EdgeInsets.all(0.0),
    this.innerPadding = const EdgeInsets.all(0.0),
    this.child,
  });
  
  @override
  _RadialProgressBarState createState() => new _RadialProgressBarState();
  }
  
  class _RadialProgressBarState extends State<RadialProgressBar> {

    EdgeInsets _insetsForPainter(){
      //Make room for painted track, progress and thumb. divide by 2.0
      //because we want to allow flush painting against the tarck, so we only need
      //to account the tickness outside the track, not inside
      final outterThickness = max(
        widget.trackWidth,
         max(
           widget.progressWidth,
            widget.thumbSize,
            ),
            ) / 2.0;
            return new EdgeInsets.all(outterThickness);
    }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outterPadding,
      child: new CustomPaint(
        foregroundPainter: new RadialSeekBarPainter(
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          progressWidth: widget.progressWidth,
          progressColor: widget.progressColor,
          progressPercent: widget.progressPercent,
          thumbSize: widget.thumbSize,
          thumbColor: widget.thumbColor,
          thumbPosition: widget.thumbPosition,

        ),
        child: new Padding(
          padding: _insetsForPainter() + widget.innerPadding,
          child: widget.child,
        ),
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter{

  final double trackWidth;
  final Paint trackPaint;
  final double progressWidth;
  final Paint progressPaint;
  final double progressPercent;
  final double thumbSize;
  final Paint thumbPaint;
  final double thumbPosition;
  

  RadialSeekBarPainter({
    @required this.trackWidth,
    @required trackColor,
    @required this.progressWidth,
    @required progressColor,
    @required this.progressPercent,
    @required this.thumbSize,
    @required thumbColor,
    @required this.thumbPosition,
    
  }) : trackPaint = new Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackWidth,
        progressPaint = new Paint()
         ..color = progressColor
         ..style = PaintingStyle.stroke
         ..strokeWidth = progressWidth
         ..strokeCap = StrokeCap.round,
         thumbPaint = new Paint()
         ..color = thumbColor
         ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {

    final outterThickness = max(trackWidth, max(progressWidth, thumbSize));
    Size constrainedSize = new Size(
    size.width - outterThickness,
    size.height - outterThickness,
    );

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    // Paint Track
    canvas.drawCircle(
      center,
      radius,
      trackPaint,
      );

    //Paint progress
    final progressAngle = 2 * pi * progressPercent;

    canvas.drawArc(
      new Rect.fromCircle(
        center: center,
        radius: radius,
      ), 
      -pi / 2, 
      progressAngle, 
      false, 
      progressPaint
      );

      //Paint thumb

      final thumbAngle = 2 * pi * thumbPosition - (pi / 2);
      final thumbX = cos(thumbAngle) * radius;
      final thumbY = sin(thumbAngle) * radius;
      final thumbCenter = new Offset(thumbX, thumbY) + center;
      final thumbRadius = thumbSize / 2;
      canvas.drawCircle(
           thumbCenter,
          thumbRadius,
          thumbPaint,
          );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}