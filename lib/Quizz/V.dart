import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressViewModel extends ChangeNotifier {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TickerProvider vsync;
  int _progress = 0;
  final int max;
  bool _animationReady = false;

  ProgressViewModel({required this.max});

  void getAnimationReady(TickerProvider vsync) {
    this.vsync = vsync;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: vsync,
    );
    _animation = Tween<double>(begin: 0, end: _progress / max).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.addListener(() {
      notifyListeners();
    });
  }

  void updateProgress(int increment) {
    _progress += increment;
    getAnimationReady(vsync);
    _animationController.forward(from: 0);
  }

  double get animationValue => _animation.value;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ProgressWidget extends StatefulWidget {
  final int max;
  late final ProgressViewModel viewModel;

  ProgressWidget({Key? key, required this.max}) : super(key: key){
    viewModel = ProgressViewModel(max: max);
  }

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    widget.viewModel.getAnimationReady(this);
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProgressViewModel>.value(
      value: widget.viewModel,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Consumer<ProgressViewModel>(
            builder: (context, viewModel, child) {
              return Container(
                width: viewModel.animationValue * MediaQuery.of(context).size.width,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
