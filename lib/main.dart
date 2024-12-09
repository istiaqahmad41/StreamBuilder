import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
void main() {

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => FutureBuilder_StreamBuilder_35_demo(),
    ),
  );

}
//Example 5: StreamBuilder WITH ONLINE IMAGES
class FutureBuilder_StreamBuilder_35_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("StreamBuilder with New Image URL")),
        body: Center(child: CustomImageStreamBuilder()),
      ),
    );
  }
}

class CustomImageStreamBuilder extends StatefulWidget {
  @override
  _CustomImageStreamBuilderState createState() => _CustomImageStreamBuilderState();
}

class _CustomImageStreamBuilderState extends State<CustomImageStreamBuilder> {
  // StreamController to control the stream of data
  StreamController<List<dynamic>> _streamController = StreamController();

  // Function to fetch data and add it to the stream
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Emit one item at a time with a delay to simulate streaming
      for (int i = 0; i < data.length; i++) {
        await Future.delayed(Duration(seconds: 1));
        _streamController.add(data.sublist(0, i + 1)); // Emit progressively more data
      }
    } else {
      _streamController.addError('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Start fetching data when the widget is initialized
  }

  @override
  void dispose() {
    _streamController.close(); // Close the stream when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        // Show a loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          return CircularProgressIndicator();
        }
        // Handle errors if the request fails
        else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        // Show the data once it's loaded
        else {
          final data = snapshot.data ?? [];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              // Using Picsum image URL for random images
              final imageUrl = 'https://picsum.photos/seed/${data[index]['id']}/300/200';

              return Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.network(
                      imageUrl, // Picsum image URL
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data[index]['title'], // Title from the JSON
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
//Example 4: StreamBuilder with API CALL
// Define a model class for the data structure.
/*class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}


class FutureBuilder_StreamBuilder_35_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter StreamBuilder Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Stream that fetches data from the API periodically.
  Stream<List<Post>> postStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Simulating periodic data fetching

      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        yield jsonResponse.map((data) => Post.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilder JSON Fetch Example'),
      ),
      body: Center(
        child: StreamBuilder<List<Post>>(
          stream: postStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                      child:  ListTile(

                        title: Text(post.title,style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                        ),






                        ),
                        subtitle: Text(post.body,style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.0,

                        ),),
                      ));
                },
              );
            } else {
              return Text('No data found');
            }
          },
        ),
      ),
    );
  }
}*/

//sample 1 ---> stream builder

/*class FutureBuilder_StreamBuilder_35_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("StreamBuilder Example")),
        body: Center(child: CounterStreamBuilder()),
      ),
    );
  }
}

class CounterStreamBuilder extends StatelessWidget {
  Stream<int> counterStream() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: counterStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return Text(
            "Counter: ${snapshot.data}",
            style: TextStyle(fontSize: 24),
          );
        }
      },
    );
  }
}*/


//Example 2: StreamBuilder with a List of Data
/*
class FutureBuilder_StreamBuilder_35_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("StreamBuilder Example")),
        body: Center(child: ListStreamBuilder()),
      ),
    );
  }
}

class ListStreamBuilder extends StatelessWidget {
  Stream<List<String>> itemStream() async* {
    List<String> items = [];
    for (String item in ['Apple', 'Banana', 'Orange', 'Grapes']) {
      await Future.delayed(Duration(seconds: 1));
      items.add(item);
      yield items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: itemStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          final data = snapshot.data ?? [];
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(data[index]));
            },
          );
        }
      },
    );
  }
}*/




//Example 3: StreamBuilder with a Timer Stream
/*
class FutureBuilder_StreamBuilder_35_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("StreamBuilder Timer Example")),
        body: Center(child: TimerStreamBuilder()),
      ),
    );
  }
}

class TimerStreamBuilder extends StatelessWidget {
  Stream<int> timerStream(int seconds) {
    return Stream.periodic(Duration(seconds: 1), (x) => seconds - x - 1)
        .take(seconds);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: timerStream(10), // 10 seconds countdown
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data == 0) {
          return Text("Time's up!", style: TextStyle(fontSize: 24));
        } else {
          return Text(
            "Seconds remaining: ${snapshot.data}",
            style: TextStyle(fontSize: 24),
          );
        }
      },
    );
  }
}*/
