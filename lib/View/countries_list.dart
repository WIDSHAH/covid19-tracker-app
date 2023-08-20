
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/states_services.dart';
import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices  statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search Country Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: statesServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return Scrollbar(
                    interactive: true,
                    thickness: 15,
                    radius: const Radius.circular(10),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  totalCases: snapshot
                                                      .data![index]['cases'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                  test: snapshot.data![index]
                                                      ['tests'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                )));
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase()) ||
                              name.toUpperCase().contains(
                                  searchController.text.toUpperCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  totalCases: snapshot
                                                      .data![index]['cases'],
                                                  totalDeaths: snapshot
                                                      .data![index]['deaths'],
                                                  totalRecovered:
                                                      snapshot.data![index]
                                                          ['recovered'],
                                                  critical: snapshot
                                                      .data![index]['critical'],
                                                  test: snapshot.data![index]
                                                      ['tests'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                )));
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                          // return Column(
                          //   children: [
                          //     ListTile(
                          //       title: Text(snapshot.data![index]['country']),
                          //       subtitle: Text(
                          //           snapshot.data![index]['cases'].toString()),
                          //       leading: Image(
                          //         height: 50,
                          //         width: 50,
                          //         image: NetworkImage(snapshot.data![index]
                          //             ['countryInfo']['flag']),
                          //       ),
                          //     )
                          //   ],
                          // );
                        }),
                  );
                } else {
                  return ListView.builder(
                      // itemCount: snapshot.data!.length,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
