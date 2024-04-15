import 'package:api_integration_with_provider/controll/homescreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getdata();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Provider = context.watch<HomeScreenController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeScreenController>().getdata();
        },
      ),
      body: Provider.isloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: Provider.resmodel?.articles?.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(Provider.resmodel?.articles?[index].title ?? ""),
              ),
            ),
    );
  }
}
