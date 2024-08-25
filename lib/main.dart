import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stability Sync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stability Sync'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text('Energy chart'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              UserHeader(),
              MarketCard(),
              PerformanceCard(data: createSampleData()),
              // Add more cards and widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        ),
        title: Text('Hello, User'),
        subtitle: Text('Welcome Back!'),
      ),
    );
  }
}

class MarketCard extends StatelessWidget {
  const MarketCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Total Power Input'),
            trailing: Text('117.22 kWh'),
          ),
          Divider(),
          ListTile(
            title: Text('Power Usage'),
            trailing: Text('This week : 75kWh'),
          ),
          Divider(),
          ListTile(
            title: Text('Electricity cost'),
            trailing: Text('This year : 78,153.64'),
          ),
        ],
      ),
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> data;

  const PerformanceCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Energy utilized'),
            trailing: Text('72.67%'),
          ),
          Divider(),
          SizedBox(
            height: 200.0,
            child: TimeSeriesChartWidget(data, animate: true),
          ),
        ],
      ),
    );
  }
}

// Function to create sample data for the chart
List<charts.Series<TimeSeriesSales, DateTime>> createSampleData() {
  final sampleData = [
    TimeSeriesSales(DateTime(2022, 9, 19), 5),
    TimeSeriesSales(DateTime(2022, 9, 26), 25),
    TimeSeriesSales(DateTime(2022, 10, 3), 100),
    TimeSeriesSales(DateTime(2022, 10, 10), 75),
  ];

  return [
    charts.Series<TimeSeriesSales, DateTime>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.sales,
      data: sampleData,
    ),
  ];
}

// Custom chart widget for displaying time series data
class TimeSeriesChartWidget extends StatelessWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;

  const TimeSeriesChartWidget(this.seriesList,
      {Key? key, required this.animate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

// Model class for time series sales data
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
