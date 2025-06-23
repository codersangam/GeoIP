import 'package:flutter/material.dart';
import 'package:geoip_api/geoip_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoIp API Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'GeoIp API Example Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GeoIpModel _ipData = GeoIpModel();

  @override
  void initState() {
    _getIpData();
    super.initState();
  }

  void _getIpData() async {
    var data = await GeoIpAPI.getData();
    setState(() {
      _ipData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("IP: ${_ipData.ip ?? 'No Data'}"),
              Text("Type: ${_ipData.type ?? 'No Data'}"),
              const SizedBox(height: 8),

              Text("Country Info:"),
              Text(" - Name: ${_ipData.country?.name ?? 'No Data'}"),
              Text(" - Code: ${_ipData.country?.countryCode ?? 'No Data'}"),
              Text(" - Continent: ${_ipData.country?.continent ?? 'No Data'}"),
              Text(" - State: ${_ipData.country?.state ?? 'No Data'}"),
              Text(" - City: ${_ipData.country?.city ?? 'No Data'}"),
              Text(" - ZIP: ${_ipData.country?.zip ?? 'No Data'}"),
              Text(" - Timezone: ${_ipData.country?.timezone ?? 'No Data'}"),
              Text(
                " - Currency: ${_ipData.country?.currencyCode ?? 'No Data'}",
              ),
              Text(
                " - EU Member: ${_ipData.country?.isEuMember == true ? 'Yes' : 'No'}",
              ),
              const SizedBox(height: 8),

              Text("Location:"),
              Text(" - Latitude: ${_ipData.location?.latitude ?? 'No Data'}"),
              Text(" - Longitude: ${_ipData.location?.longitude ?? 'No Data'}"),
              const SizedBox(height: 8),

              Text("ASN:"),
              Text(" - Number: ${_ipData.asn?.number ?? 'No Data'}"),
              Text(" - Name: ${_ipData.asn?.name ?? 'No Data'}"),
              Text(" - Network: ${_ipData.asn?.network ?? 'No Data'}"),
              Text(" - Type: ${_ipData.asn?.type ?? 'No Data'}"),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: _getIpData,
                  child: Text(
                    "Refresh GeoIP Data",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
