import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AccountContent extends StatelessWidget {
  Widget _buildAddSwimmerButton(BuildContext context) {
    Widget button = PlatformButton(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(
            width: 8,
          ),
          PlatformText(
            'Swimmer',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      onPressed: () {},
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 1.5,
        )),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
    );
    var wrapWithStadiumBorder = false;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        wrapWithStadiumBorder = true;
        break;
      default:
        break;
    }
    if (wrapWithStadiumBorder) {
      button = Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1.5,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: button,
      );
    }
    return button;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildAddSwimmerButton(context),
            )
          ],
        )
      ],
    );
//    return Container(
//      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//      child: ListView.builder(
//        itemCount: 9,
//        itemBuilder: (content, index) {
//          return Container(
//            padding: EdgeInsets.symmetric(vertical: 12),
//            child: PlaceholderCardShort(
//                color: Constants.darkBackgroundColor,
//                backgroundColor: Constants.darkBackgroundColor),
////            child: PlaceholderCardShort(color: Color(0xFF99D3F7), backgroundColor: Color(0xFFC7EAFF)),
//          );
//        },
//      ),
//    );
  }
}
