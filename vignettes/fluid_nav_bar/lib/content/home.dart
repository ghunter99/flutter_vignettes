import 'package:flutter/material.dart';

import '../constants.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // do not show ripple on button tap for iOS or macOS
    var color = Colors.transparent;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        color = Constants.darkPinkColor;
        break;
      default:
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          color: Constants.darkPinkColor,
          child: Container(
            height: 42,
            color: color,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TabBar(
              controller: _tabController,
              labelColor: Constants.darkPinkColor,
              unselectedLabelColor: Constants.darkUnselectedTabLabelColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Constants.darkPinkColor,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
//            isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(50),
//                      border: Border.all(color: Colors.white, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "FAMILIES",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(50),
//                      border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SWIMMERS",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: screenHeight - 66,
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (content, index) {
                    var avatarColor = Constants.darkCyanColor;
                    if (index == 1) avatarColor = Color(0xFF37598C);
                    if (index == 2) avatarColor = Color(0xFFf4a647);
                    return Card(
                      color: Constants.darkListTileBackgroundColor,
                      child: ListTile(
                        title: Text(
                          'Susanna Hunter',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Phone: 0431 995 292',
                          style: TextStyle(color: Constants.darkPinkColor),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: avatarColor,
                          foregroundColor: Colors.white,
                          child: Text('AH'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (content, index) {
                    var avatarColor = Constants.darkCyanColor;
                    if (index == 1) avatarColor = Color(0xFF37598C);
                    if (index == 2) avatarColor = Color(0xFFf4a647);
                    if (index == 3) avatarColor = Constants.darkCyanColor;
                    if (index == 4) avatarColor = Constants.darkPinkColor;
                    if (index == 5) avatarColor = Color(0xFF37598C);
                    if (index == 6) avatarColor = Color(0xFFf4a647);
                    if (index == 7) avatarColor = Constants.darkCyanColor;
                    if (index == 8) avatarColor = Constants.darkPinkColor;
                    if (index == 9) avatarColor = Color(0xFF37598C);
                    if (index == 10) avatarColor = Color(0xFFf4a647);
                    if (index == 11) avatarColor = Constants.darkCyanColor;
                    if (index == 12) avatarColor = Constants.darkPinkColor;
                    return Card(
                      color: Constants.darkListTileBackgroundColor,
                      child: ListTile(
                        title: Text(
                          'Beatrix Hunter',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Age: 11    Female',
                          style: TextStyle(color: Constants.darkPinkColor),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: avatarColor,
                          foregroundColor: Colors.white,
                          child: Text('AH'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
