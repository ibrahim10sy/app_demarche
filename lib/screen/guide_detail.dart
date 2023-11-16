import 'package:demarche_app/model/Guide.dart';
import 'package:demarche_app/service/guideService.dart';
import 'package:flutter/material.dart';

class GuideDetail extends StatefulWidget {
  final Guide guide;
  const GuideDetail({super.key, required this.guide});

  @override
  State<GuideDetail> createState() => _GuideDetailState();
}

class _GuideDetailState extends State<GuideDetail> {
  late Guide guides;
  @override
  void initState() {
    guides = widget.guide;
    print(guides.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('guide details'),
      ),
    );
  }
}
