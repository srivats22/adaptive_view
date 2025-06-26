import 'package:flutter/material.dart';
import 'package:adaptive_view/adaptive_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdaptView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = List.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdaptView Demo'),
      ),
      body: AdaptiveView(
        listBuilder: (context, onItemTap) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () => onItemTap(index),
              );
            },
          );
        },
        detailBuilder: (context, selectedIndex) {
          if (selectedIndex == null) {
            return const Center(
              child: Text('Select an item from the list'),
            );
          }
          return Center(
            child: Text('Details for ${items[selectedIndex]}'),
          );
        },
        breakpoint: 600.0, // Optional: custom breakpoint
        animateTransitions: true, // Optional: enable/disable animations
      ),
    );
  }
}