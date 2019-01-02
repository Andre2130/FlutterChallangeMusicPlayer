import 'package:meta/meta.dart';

final demoPlaylist = new DemoPlaylist(

  songs: [
    new DemoSong(
      audioUrl: 'https://wethesauce.com/wp-content/uploads/2018/12/01-Ghetto-Gospel.mp3',
      albumArtUrl: 'http://wethesauce.com/wp-content/uploads/2018/12/01-Ghetto-Gospel-mp3-image.jpg',
      songTitle: 'Ghetto Gospel',
      artist: 'Sauce Walka'

    ),
    new DemoSong(
      audioUrl: 'https://wethesauce.com/wp-content/uploads/2018/11/Chance_the_Rapper_-_The_Man_Who_Has_Everything_NaijaExclusive.net_.mp3',
      albumArtUrl: 'http://wethesauce.com/wp-content/uploads/2018/11/MWHECover.png',
      songTitle: 'The Man Who Has Everything',
      artist: 'Chance the Rapper'

    ),
    new DemoSong(
      audioUrl: 'https://wethesauce.com/wp-content/uploads/2018/11/03.-Kaytranada-Shay-Lia-Chances.mp3',
      albumArtUrl: 'http://wethesauce.com/wp-content/uploads/2018/11/01-Kaytranada-Ty-Dolla-ign-Nothin-Like-U-mp3-image.jpg',
      songTitle: 'CHANCES',
      artist: 'KAYTRANADA, Shay Lia'

    )
  ]
);

class DemoPlaylist{
  final List<DemoSong> songs;

  DemoPlaylist({
    @required this.songs,
  });
}


class DemoSong {

  final String audioUrl;
  final String albumArtUrl;
  final String songTitle;
  final String artist;

  DemoSong({
    @required this.audioUrl,
    @required this.albumArtUrl,
    @required this.songTitle,
    @required this.artist,
  });

}