import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'V.dart';

class LadebalkenDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animierter Ladebalken'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgressWidget(max: 100),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final viewModel = Provider.of<ProgressViewModel>(context, listen: false);
                    if (viewModel.animationValue < 1) {
                      viewModel.updateProgress((viewModel.animationValue * 100).toInt() + 10);
                    }
                  },
                  child: Text('Füllen'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    final viewModel = Provider.of<ProgressViewModel>(context, listen: false);
                    if (viewModel.animationValue > 0) {
                      viewModel.updateProgress((viewModel.animationValue * 100).toInt() - 10);
                    }
                  },
                  child: Text('Leeren'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LadebalkenDemo(),
  ));
}
