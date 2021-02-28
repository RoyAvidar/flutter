import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutUsScreen extends StatelessWidget {
  static const routName = '/aboutUs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About our Pizza'),
        ),
        drawer: AppDrawer(),
        body: Column(
          children: [
            Text(
              'Pizza\'le',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).accentColor,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
                'A wall of text consists of many lines of text that resemble a wall. A wall of text can sometimes be really big or somewhat small. Most walls of text lack grammar so they are not as appealing to read while other walls of text do contain grammar so they are actually easy to read but not as long as if you were to put a bunch of random characters or words. A wall of text might be made out of word bricks which kind of makes sense if you think of each word as a brick but that would be a tall and narrow wall unless you expand it in which case it will be a large wall in general. Most places do not allow walls of text because they count as spam and could get you banned or kicked or muted and will prevent you from posting other walls of text. Some places allow walls of text but that would be weird and probably doesn\'t exist. If such a platform did exist for creating walls of text and publishing them for viewers then it is probably not popular otherwise I would have seen it by now. You should refrain from posting walls of text because of the reason I stated up there that said that you could get muted for spam and another reason being that it might get a lot of dislikes or even flagged for spam. If you get flagged for spam then you will no longer be able to post walls of text which is pretty reasonable but I think people should be able to express themselves but probably not through walls of text unless you want to. I have come across a few walls of text and some of them are funny but some of them are short and there are rarely any long walls of text. Maybe walls of text were created by early internet users to troll others but that would be extremely slow because you get like a byte per second download and like a bit per second upload or something like that idk I didn\'t live with dial up so i wouldn\'t know about the internet speeds but they are probably accurate even though i should fact check that. People who create walls of text probably have a lot of time on their hands or are really boring or both and they might have very long attentions spans or maybe they are entertained by creating a wall of text because it lets them be creative with what they say.'),
          ],
        ));
  }
}
