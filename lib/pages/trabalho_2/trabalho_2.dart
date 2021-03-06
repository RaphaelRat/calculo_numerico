import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      height: 112,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                        border: Border.all(width: 1, color: Get.isDarkMode ? Colors.white : Theme.of(context).focusColor),
                      ),
                      child: controller.integral.isEmpty
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
                                Column(
                                  children: [
                                    Text(
                                      controller.b.value.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 54, child: Image.asset('assets/integral.png')),
                                    Text(
                                      controller.a.value.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(children: [
                                  for (int i = 0; i < controller.integral.length; i++) ...[
                                    Text(
                                      controller.integral[i]['operacao'] ?? '',
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      controller.integral[i]['numero'] ?? '',
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      controller.integral[i]['x'] ?? '',
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Text(controller.integral[i]['expoente'] ?? '',
                                        style: const TextStyle(fontSize: 8, color: Colors.black, fontWeight: FontWeight.bold)),
                                  ],
                                ]),
                                // Text(
                                //   '${controller.integral.toString()}  dx',
                                //   style: const TextStyle(
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                const Text('   dx', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 16),
                                VerticalDivider(color: Get.isDarkMode ? Colors.white : Theme.of(context).focusColor),
                                const SizedBox(width: 16),
                                Text(
                                  'n = ${controller.n.value}',
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
                  const Text('Entre com a função:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _myTextField(
                    context,
                    hintText: '2x+1/x',
                    onChanged: (value) {
                      if (value.length > 1 && (value[value.length - 1] == '+' || value[value.length - 1] == '-')) {
                        if (value[value.length - 2] == '+' || value[value.length - 2] == '-') {
                          controller.funcaoController.text = value.substring(0, value.length - 2) + value.substring(value.length - 1);
                          controller.funcaoController.selection =
                              TextSelection.fromPosition(TextPosition(offset: controller.funcaoController.text.length));
                        }
                      }
                      controller.createIntegral();
                    },
                    isOnlyNumber: false,
                    controller: controller.funcaoController,
                  ),
                  const SizedBox(height: 12),
                  const Text('Entre com o intervalo:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text('a:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: _myTextField(context, hintText: '1', onChanged: (value) {
                          controller.a.value = value.isEmpty ? 1 : double.parse(value);
                        }),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('b:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: _myTextField(context, hintText: '2', onChanged: (value) {
                          controller.b.value = value.isEmpty ? 2 : double.parse(value);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Entre com o valor de n:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _myTextField(context, hintText: '10', onChanged: (value) {
                    controller.n.value = value.isEmpty ? 10 : int.parse(value);
                  }),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: controller.trapeziosClicked,
                        child: const Text('Regra dos Trapézios'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: controller.simpsonClicked,
                        child: const Text('Regra do Simpson'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField _myTextField(
    BuildContext context, {
    Function(String value)? onChanged,
    String? hintText,
    bool isOnlyNumber = true,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Theme.of(context).focusColor,
      cursorWidth: 1.0,
      keyboardType: isOnlyNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isOnlyNumber ? [] : [FilteringTextInputFormatter.allow(RegExp(r'[0-9-/+xX]'))],
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
