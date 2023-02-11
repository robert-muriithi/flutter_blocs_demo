import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocs_demo/repository/beers_repository.dart';

import 'blocs/beers_bloc.dart';
import 'blocs/beers_event.dart';
import 'blocs/beers_states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Beers'),
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



  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BeersBloc>(
            create: (context) => BeersBloc(beersRepository: BeersRepository()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: BlocProvider(
            create: (context) => BeersBloc(beersRepository: BeersRepository())..add(const BeersFetched()),
            child: BlocBuilder<BeersBloc, BeersState>(
              builder: (context, state) {
                if (state is BeersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is BeersLoaded) {
                  return GridView(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      children: [
                        for (var beer in state.beers)
                          Card(
                            child: Column(
                              children: [
                                Expanded(child: Image.network(beer.imageUrl, fit: BoxFit.cover, ),
                                ),
                                Text(beer.name),
                              ],
                            ),
                          )
                    ]
                  );
                } else if (state is BeersError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              },
            ),
          ),
          /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<BeersBloc>().add(const BeersFetched());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),*/
        )
    );
  }
}
