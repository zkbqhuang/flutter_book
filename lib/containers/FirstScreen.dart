import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_book/widgets/FirstScreen/FirstScreenContent.dart';
import 'package:provider/provider.dart';
import 'package:flutter_book/stores/homeStore.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_book/helpers/constants.dart';
import 'package:flutter_book/widgets/common/MyHeader.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with AutomaticKeepAliveClientMixin {
  HomeStore homeStore;
  EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    // 下拉刷新
    _controller = EasyRefreshController();
    // 发送请求
    Future(() {
      homeStore = Provider.of<HomeStore>(
        this.context,
        listen: false,
      );
      homeStore.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      enableControlFinishRefresh: false,
      bottomBouncing: Theme.of(context).platform == TargetPlatform.iOS,
      header: MyHeader(
          refreshedText: "更新成功",
          refreshFailedText: "刷新失败，请稍后重试",
          refreshReadyText: "松手刷新",
          refreshingText: "正在更新内容",
          refreshText: "下拉刷新",
          textColor: Color(AppColors.fontColorGray),
          showInfo: false),
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                left: Constants.pageMargin,
                right: Constants.pageMargin,
                top: 20.0,
                bottom: 40),
            child: FirstScreenContent(),
          ),
        ],
      ),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          // _controller.resetLoadState();
          _controller.finishRefresh(success: true);
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
