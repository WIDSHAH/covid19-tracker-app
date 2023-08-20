
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../model/WorldStatesModel.dart';
import '../services/states_services.dart';
import 'countries_list.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(milliseconds: 2500), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  // final colorList = <Color>[
  //   const Color(0xff4285F4),
  //   const Color(0xff1aa260),
  //   const Color(0xffde5246),
  // ];

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text(
              'Do you really want to exit an App?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () => Navigator.of(context).pop(),
                //return false when click on "NO"
                child: Text('No', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () => SystemNavigator.pop(),
                //return true when click on "Yes"
                child: Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   centerTitle: true,
        //   title: const Text('World States'),
        // ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              // 'Total': 100,
                              // 'Recovered': 77,
                              // 'Deaths': 23,
                              'Total':
                                  double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Deaths': double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration: const Duration(seconds: 4),
                            chartType: ChartType.ring,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            colorList: const [
                              Color(0xff4285F4),
                              Color(0xff1aa260),
                              Color(0xffde5246),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .05),
                            child: Card(
                              child: Column(
                                children: [
                                  // ReusableRow(title: 'Total', value: '200'),
                                  // ReusableRow(title: 'Total', value: '200'),
                                  // ReusableRow(title: 'Total', value: '200'),
                                  ReusableRow(
                                      title: 'Updated Cases',
                                      value: snapshot.data!.updated.toString()),
                                  ReusableRow(
                                      title: "Today's Cases",
                                      value:
                                          snapshot.data!.todayCases.toString()),
                                  ReusableRow(
                                      title: "Today's Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                  ReusableRow(
                                      title: "Today's Deaths",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReusableRow(
                                      title: 'Affected Countries',
                                      value: snapshot.data!.affectedCountries
                                          .toString()),
                                  ReusableRow(
                                      title: 'Total Active Cases',
                                      value: snapshot.data!.active.toString()),
                                  ReusableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesList()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 50,
                              width: 150,
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ));
                    }
                  }),

              /*PieChart(
                dataMap: const {
                  'Total': 100,
                  'Recovered': 77,
                  'Deaths': 23,
                },
                animationDuration: const Duration(seconds: 2),
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left,
                ),
                colorList: const [
                  Color(0xff4285F4),
                  Color(0xff1aa260),
                  Color(0xffde5246),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .05),
                child: Card(
                  child: Column(
                    children: [
                      ReusableRow(title: 'Total', value: '200'),
                      ReusableRow(title: 'Total', value: '200'),
                      ReusableRow(title: 'Total', value: '200'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  width: 150,
                  child: const Center(
                    child: Text(
                      'Track Countries'
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        )),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
