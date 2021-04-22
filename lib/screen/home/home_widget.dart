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

  HomeIntentLogic _intent;
  List<RepositoryItemViewModel> _items = List.empty();
  bool _isLoading = true;
  bool _isError = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _intent = HomeIntent();
    _refresh();
  }

  void _refresh() async {
    try {
      final newItems = await _intent.reload();
      this.setState(() {
        _items = newItems;
        _isError = false;
        _isLoading = false;
      });
    } catch(err) {
      this.setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  void _loadMore() async {
    try {
      final newItems = await _intent.next();
      this.setState(() {
        _items += newItems;
        _isError = false;
        _isLoading = false;
      });
    } catch(err) {
      this.setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
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
          errorMessage(),
          feed()
        ],
      ),
    );
  }

  Widget feed() {
    return Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) => fetch(scrollInfo),
              child: list(),
            ),
          );
  }

  ListView list() {
    return ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return RepositoryItemWidget(
                    viewModel: _items[index]
                  );
                },
              );
  }

  Widget errorMessage() {
    if (_isError) {
      return Text("api error");
    } else {
      return Container();
    }
  }
  bool fetch(ScrollNotification scrollInfo) {
    if (shouldFetch(scrollInfo)) {
      // start loading data
      setState(() {
        _isLoading = true;
      });

      _loadMore();
    }

    return true;
  }

  bool shouldFetch(ScrollNotification scrollInfo) {
    return _isLoading == false 
    && _intent.shouldBatch() 
    && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
  }
}
