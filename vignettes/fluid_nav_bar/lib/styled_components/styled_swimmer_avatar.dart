import 'dart:math';

import 'package:flutter/material.dart';

import '../model/swimmer_account.dart';

class StyledSwimmerAvatar extends StatefulWidget {
  const StyledSwimmerAvatar({Key key, this.account, this.size})
      : super(key: key);
  final SwimmerAccount account;
  final double size;

  @override
  _StyledSwimmerAvatarState createState() => _StyledSwimmerAvatarState();
}

class _StyledSwimmerAvatarState extends State<StyledSwimmerAvatar> {
  int _seed;

  @override
  void initState() {
    _seed = widget.account?.id?.hashCode ?? 0;
    super.initState();
  }

  @override
  void didUpdateWidget(StyledSwimmerAvatar oldWidget) {
//    if (oldWidget.contact.profilePicBytes != widget.contact.profilePicBytes) {
//      setState(() {});
//    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
//    if (widget.contact.profilePicBytes != null) {
//      child = Image.memory(widget.contact.profilePicBytes, fit: BoxFit.cover);
//    } else if (widget.contact.profilePic != null && !widget.contact.isDefaultPic) {
//      child = Image.network(widget.contact.profilePic, fit: BoxFit.cover);
//    } else {
    child = AnimalAvatar(seed: _seed);
//    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: Container(
        width: widget.size ?? 50,
        height: widget.size ?? 50,
        child: child,
      ),
    );
  }
}

class AnimalAvatar extends StatelessWidget {
  const AnimalAvatar({Key key, this.seed}) : super(key: key);
  final int seed;

  List<Color> get backgrounds => const [
        Color(0xFF44D3B8),
        Color(0xFFACC66B),
        Color(0xFF915599),
        Color(0xFF85CADB),
        Color(0xFF37598C),
        Color(0xFF5A5587),
        Color(0xFFD4B99F),
        Color(0xFFEDABA9),
        Color(0xFFE09BD6),
        Color(0xFFF4A647),
      ];

  List<String> get foregrounds => const [
        'bird-hummingbird',
        'bird-parrot',
        'bird-pelican',
        'bird-swan',
        'bird-woodpecker',
        'bird-flamingo',
        'bird-owl',
        'bird-peacock',
        'bird-penguin',
        'bird-toucan',
      ];

  @override
  Widget build(BuildContext context) {
    final Random r = Random(seed);
    return Stack(
      children: <Widget>[
        Container(
          color: backgrounds[r.nextInt(backgrounds.length)],
        ),
        Image.asset(
            'assets/images/birds/${foregrounds[r.nextInt(foregrounds.length)]}.png'),
      ],
    );
  }
}

//Widget _buildAvatar(double size) {
//  Widget content = (widget.contact.profilePic == null
//                    ? Container()
//                    : ClipRRect(
//    borderRadius: BorderRadius.circular(999),
//    child: Image.network(widget.contact.profilePic, fit: BoxFit.cover),
//    ));
//  return content.constrained(width: size, height: size);
//}
