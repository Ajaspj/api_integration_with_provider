import 'package:api_integration_with_provider/controll/homescreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? selectedcountrydropdown;

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

    return DefaultTabController(
      length: Provider.categories.length,
      child: Scaffold(
        appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: DropdownButton(
                  hint: Text("country"),
                  style: TextStyle(color: Colors.black),
                  items: List.generate(
                      Provider.Country.length,
                      (index) => DropdownMenuItem(
                            child: Text(Provider.Country[index]),
                            value: Provider.Country[index],
                          )),
                  onChanged: (value) {
                    selectedcountrydropdown = value;
                  },
                ),
              )
            ],
            bottom: TabBar(
                isScrollable: true,
                onTap: (value) {
                  context
                      .read<HomeScreenController>()
                      .oncatagoryselection(value);
                },
                tabs: List.generate(
                    Provider.categories.length,
                    (index) => Tab(
                          child: Text(Provider.categories[index].toUpperCase()),
                        )))),
        body: Provider.isloading
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: Provider.rescatagory?.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.amber,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: Image.network(
                              "${Provider.rescatagory?.articles?[index].urlToImage}"),
                        ),
                        Text(
                          "${Provider.rescatagory?.articles?[index].title?.toUpperCase()}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${Provider.rescatagory?.articles?[index].description?.toLowerCase()}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    )),
      ),
    );
  }
}
