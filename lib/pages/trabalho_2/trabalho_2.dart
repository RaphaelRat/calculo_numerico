import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './trabalho_2_controller.dart';

class Trabalho2 extends GetView<Trabalho2Controller> {
  const Trabalho2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('T2 - Questão 4'), centerTitle: true),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                        border: Border.all(width: 1, color: Theme.of(context).focusColor),
                      ),
                      child: controller.integral.value.isEmpty
                          ? const Center(
                              child: Text(
                                'Sua integral aqui',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/integral.png'),
                                Text(
                                  controller.integral.value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Entre com a integral:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _myTextField(context, hintText: '2x+1/x', onChanged: (value) => controller.funcao.value = value),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField _myTextField(BuildContext context, {Function(String value)? onChanged, String? hintText}) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).focusColor, width: 3.0, style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1.0),
        ),
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
