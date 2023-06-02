import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingService {
  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const CupertinoAlertDialog(
          title: Text("Please waiting"),
          content: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: CupertinoActivityIndicator(
                radius: 30,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
