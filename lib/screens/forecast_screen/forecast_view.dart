import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class ForecastView extends StatefulWidget {
  const ForecastView({Key? key, required this.snapshot}) : super(key: key);
  final List<Weather> snapshot;
  @override
  _ForecastViewState createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            size.height * 0.005,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: widget.snapshot.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'http://openweathermap.org/img/w/${widget.snapshot[index].weatherIcon.toString()}.png'),
                                fit: BoxFit.contain)),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  DateFormat('EEEE, d MMM, yyyy' ' kk:mm:a')
                                      .format(DateTime.parse(widget
                                          .snapshot[index].date
                                          .toString())),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.snapshot[index].weatherDescription
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 10),
                        child: Text(
                          widget.snapshot[index].temperature.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
