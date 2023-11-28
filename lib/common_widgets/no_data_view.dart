import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("images/no-data.png",
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 5,),
        const Text('No Data to display!',
          style: TextStyle(
              fontSize: 18
          ),),
      ],
    );
  }
}