import 'dart:math';

import 'package:first_flutter_app/theam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: accentColor,
      child: new Material(
        color: accentColor,
        shadowColor: const Color(0x44000000),
                    child: Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 50),
          child: new Column(
            children: <Widget>[
              new RichText(
                text: new TextSpan(
                  text: '',
                  children: [
                    new TextSpan(
                      text: 'Song Title\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        height: 1.5,
                      )
                    ),
                    new TextSpan(
                      text: 'Artist Name',
                      style: new TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12,
                        letterSpacing: 3,
                        height: 1.5,
                      ),
                    )
                  ]
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(top: 40),
                 child: Row(
                  children: <Widget>[
                    new Expanded(child: new Container()),

                    new PreviousButton(),

                    new Expanded(child: new Container()),


                    new PlayPauseButton(),


                    new Expanded(child: new Container()),


                    new NextButton(),


                    new Expanded(child: new Container(),)
                  ],
              ),
               )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayerState,
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child){

        IconData icon = Icons.music_note;
        Color buttonColor = lightAccentColor;
        Function onPressed;


        if(player.state == AudioPlayerState.playing){

          icon = Icons.pause;
          onPressed = player.pause;
          buttonColor = Colors.white;

        }else if(player.state == AudioPlayerState.paused
        || player.state == AudioPlayerState.completed){

          icon = Icons.play_arrow;
          onPressed = player.play;
          buttonColor = Colors.white;

        }
        return new RawMaterialButton(
        shape: new CircleBorder(),
        fillColor: buttonColor,
        splashColor: lightAccentColor,
        highlightColor: lightAccentColor.withOpacity(.5),
        elevation: 10.0,
        highlightElevation: 5,
        onPressed: onPressed,
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Icon(
            icon,
            color: darkAccentColor,
            size: 35,
          ),
        ),
      );
      },
          
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: new Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: (){
        // TODO:
      },
      );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: new Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: (){
        // TODO:
      },
      );
  }
}


class CircleClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
      center: new Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    
    return true;
  }

}