import 'package:first/app/modules/authentication/wrapper/wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WrapperView extends GetView<WrapperController> {
  const WrapperView({super.key});

  @override
  Widget build(BuildContext context) {
  return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
  
}