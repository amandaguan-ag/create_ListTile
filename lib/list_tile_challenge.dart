import 'package:flutter/material.dart';

class StreamBuilderExample extends StatelessWidget {
  StreamBuilderExample({Key? key}) : super(key: key);

  Stream<int> streamListOfSquares(int n) async* {
    for (int i = 0; i < n; ++i) {
      //yield is keyword to 'return' the current element of the stream
      await Future.delayed(const Duration(seconds: 1));
      yield i * i;
    }
  }

  final List<int> integerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder Example'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: streamListOfSquares(10),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              integerList.add(snapshot.data!);
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('The item number is ${integerList[index]}'),
                    subtitle: Text('The index is $index'),
                  );
                },
                itemCount: integerList.length,
              );
            } else {
              return const Text('Something wrong happened.');
            }
          },
        ),
      ),
    );
  }
}
