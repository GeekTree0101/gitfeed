import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_intent.dart';
import 'package:gitfeed/widget/repository_item.dart';

class HomeWidget extends StatefulWidget {

  // key
  HomeWidget({Key key}): super(key: key);
  
  // createState
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget> {

  HomeIntentLogic _intent = HomeIntent();
  List<RepositoryItemViewModel> _items = List.empty();
  bool _isLoading = false;

  void _refresh() async {
    final newItems = await _intent.reload();
    this.setState(() {
      _items = newItems;
    });
  }

  void _loadMore() async {
    final newItems = await _intent.next();
    this.setState(() {
      _items += newItems;
    });
  }

  void _didSelectItem(int id) {
    final repo = _intent.getRepositoryByID(id);
    // todo navigate to detail
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          feed(),
          loadingIndicator()
        ],
      ),
    );
  }

  Widget feed() {
    return Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  _refresh();
                  // start loading data
                  setState(() {
                    _isLoading = true;
                  });
                }

                return;
              },
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return RepositoryItemWidget(
                    viewModel: _items[index]
                  );
                },
              ),
            ),
          );
  }

  Widget loadingIndicator() {

    return Container(
            height: _isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          );
  }
}
