import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  PackageInfo? packageInfo;

  Future<void> _getInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('AppName: ${packageInfo?.appName}'),
            const SizedBox(height: 4),
            Text('PackageName: ${packageInfo?.packageName}'),
            const SizedBox(height: 4),
            Text('Version: ${packageInfo?.version}'),
            const SizedBox(height: 4),
            Text('BuildNumber: ${packageInfo?.buildNumber}'),
            const SizedBox(height: 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getInfo,
        tooltip: 'Get info',
        child: const Icon(Icons.info),
      ),
    );
  }
}
