import 'package:flutter/material.dart';
import 'package:api/Model/usermodel1.dart';
import 'package:api/Services/api_service1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<AsyncSnapshot<User>>? _userData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUser(); // Load user data when the app starts
  }

  void _fetchUser() {
    setState(() {
      _isLoading = true;
      _userData = ApiService.fetchUser().whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            'API Integration',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _userData == null,
              child: Center(
                child: ElevatedButton(
                  onPressed: _fetchUser,
                  child: Text('Get Data'),
                ),
              ),
            ),
            Visibility(
              visible: _userData != null,
              child: Expanded(
                child: FutureBuilder<AsyncSnapshot<User>>(
                  future: _userData!,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final user = snapshot.data!.data;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Name: ${user!.title} ${user.firstName} ${user.lastName}'),
                          const SizedBox(height: 20),
                          Text('Gender: ${user.gender}'),
                          if (!_isLoading)
                            Center(
                              child: ElevatedButton(
                                onPressed: _fetchUser,
                                child: Text('Get Data'),
                              ),
                            ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}












// import 'package:api/Model/usermodel1.dart';
// import 'package:api/Services/api_service1.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   Future<AsyncSnapshot<User>>? _userData;
//   // The _userData  is a Future that will hold the user data fetched from the API.
//   bool _isLoading = false;
//   // _isLoading  is a boolean  indicating whether the data is currently being loaded.
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void _fetchUser() {
//
//     setState(() {
//       _isLoading = true;
//       _userData = ApiService.fetchUser().whenComplete(() {
//         setState(() {
//           _isLoading = false;
//         });
//       });
//     });
//   }
//   // The _fetchUser() method is responsible for fetching user data from the API
//   // It sets the _isLoading flag to true,
//   // initiates the API request, and updates the _userData variable with the result.
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.indigo,
//           title: const  Text(
//             'API Integration',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: Column(
//           //Inside the Column, there are conditional widgets based on the value of _userData.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //If _userData is null, it displays a centered ElevatedButton with the text 'Get Data
//             if (_userData == null)
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _fetchUser,
//                   child: const Text('Get Data'),
//                 ),
//               ),
//
//             if (_userData != null)
//               //If _userData is not null, it displays a FutureBuilder widget.
//               //The FutureBuilder widget listens to the Future represented by _userData
//               Expanded(
//                 child: FutureBuilder<AsyncSnapshot<User>>(
//                   future: _userData,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       //While the future is loading, it shows a CircularProgressIndicator
//                       return const  Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       //If an error occurs during loading, it displays an error message.
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else {
//                       //Once the future completes successfully, it retrieves the user data from the snapshot.
//                       //It then displays the user's name and gender using the Text widget.
//                       final user = snapshot.data!.data;
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Name: ${user!.title} ${user.firstName} ${user.lastName}',),
//                           const SizedBox(height: 20),
//                           Text('Gender: ${user.gender}'),
//                           if (!_isLoading)
//                             //If _isLoading is false,it shows another centered ElevatedButton with the text 'Get Data',
//                             // allowing the user to fetch data again.
//                             Center(
//                               child: ElevatedButton(
//                                 onPressed: _fetchUser,
//                                 child: const Text('Get Data'),
//                               ),
//                             ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
