// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:covid_pass/models/Infomodel.dart';
import 'package:flutter/material.dart';
import '../../../Functions/get_info.dart';

class MyStat extends StatefulWidget {
  const MyStat({Key? key}) : super(key: key);

  @override
  State<MyStat> createState() => _MyStatState();
}

class _MyStatState extends State<MyStat> {
  String dateFormater(int value) {
    if (value < 10) {
      return "0$value";
    }
    return value.toString();
  }

  Color dayDifference(int dayInterval) {
    if (dayInterval > 7) {
      return Colors.red;
    }
    return Colors.white;
  }

  String addedString(int dayInterval) {
    if (dayInterval > 7) {
      return "you need to take a test again!";
    }
    return "!";
  }

  String positiveResultLeftDays(int dayInterval) {
    int dayLeft = 14 - dayInterval;
    if (dayLeft <= 0) {
      return "you have already finished your quarantine time, so you have to take a test again";
    } else if (dayLeft == 1) {
      return "you are only one day away from finishing your quarantine time";
    }
    return "you are $dayLeft days away from finishing your quarantine. hold on a little longer";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InfoModel?>(
        future: getDocuments.getInfo(),
        builder: ((BuildContext context, AsyncSnapshot<InfoModel?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if(snapshot.data!.last_tested == null){
                return Center(child:Text("you did not take a test yet try to contact wudassie"));
              }

              
              InfoModel? model = snapshot.data;
              final difference =
                  DateTime.now().difference(model!.last_tested!.toDate());
              return Column(
                children: [
                  SizedBox(
                    height: 200.0,
                    child: Card(
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "last tested ",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                dateFormater(model.last_tested!.toDate().day) +
                                    "/" +
                                    dateFormater(
                                        model.last_tested!.toDate().month) +
                                    "/" +
                                    model.last_tested!.toDate().year.toString(),
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 23.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "last result ",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                model.testresult?? false ? "Negative" : "Positive",
                                style: TextStyle(
                                  color: model.testresult?? false
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 19.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: Card(
                      margin: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: model.testresult?? false
                              ? Text(
                                  "It has been ${difference.inDays == 1 ? "a" : difference.inDays} ${difference.inDays == 1 ? "day" : "days"} since you last took a test ${addedString(difference.inDays)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: dayDifference(difference.inDays),
                                    fontSize: 19.0,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              : Text(
                                  "It has been ${difference.inDays} days since you took your last test. ${positiveResultLeftDays(difference.inDays)}",
                                  style: TextStyle(
                                    fontSize: 19.0,
                                    fontStyle: FontStyle.italic,
                                    color: difference.inDays >= 14
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("error loading"),
              );
            }
          }
          return Center(
            child: Text(snapshot.error.toString() + " snapshot has error"),
          );
        }));
  }
}
