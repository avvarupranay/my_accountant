import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_accountant/Global/common_utils.dart';

class ExpenseManagementSelectorLayout extends StatelessWidget {
  const ExpenseManagementSelectorLayout({super.key, required this.content , required this.callBack});

  final String content;
  final void Function()? callBack;
  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedContainer(
          padding: EdgeInsetsDirectional.only(
            bottom: 0.05 * MediaQuery.of(context).size.height,
          ),
          duration: const Duration(seconds: 1),
          child: SizedBox(
            width: 0.85 * MediaQuery.of(context).size.width,
            height: 100,
            child: Card(
              elevation: 50,
              color: defaultScreenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      width: 4,
                      color: Colors.black
                  )
              ),
              child: InkWell(
                onTap: callBack,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Wrap(children: [
                          Center(
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 30,
                                      end: 30
                                  ),
                                  child: Text(
                                      content,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15
                                      )
                                  )
                              )
                          )
                        ]
                        )
                    ),
                    const Padding(
                        padding: EdgeInsetsDirectional.all(25),
                        child: Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.black, size: 40
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
