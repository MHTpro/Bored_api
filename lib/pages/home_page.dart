import 'package:flutter/material.dart';
import 'package:my_api/api/my_api.dart';
import 'package:my_api/models/my_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<MainModel>? response;

  @override
  void initState() {
    //api_request
    response = getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Are you bored? check this:",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(
                  height: 80.0,
                ),

                //api_response --start
                FutureBuilder(
                  future: response,
                  builder: (BuildContext context,
                      AsyncSnapshot<MainModel> snapshot) {
                    if (!(snapshot.hasData)) {
                      return const CircularProgressIndicator();
                    }
                    return response == null
                        ? const Center(
                            child: Text("Can't load the data.try again"),
                          )
                        : Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 550.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Type:${snapshot.data!.type}\n\nPrice:${snapshot.data!.price}\n\nAccessibility:${snapshot.data!.accessibility}\n\nParticipants:${snapshot.data!.participants}",
                                      style: TextStyle(
                                        color: Colors.purple.shade900,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Link:",
                                          style: TextStyle(
                                            color: Colors.purple.shade900,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        //if there is a link, The(TextButtom) will be activated
                                        snapshot.data!.link.isEmpty
                                            ? Text(
                                                "None",
                                                style: TextStyle(
                                                  color: Colors.purple.shade900,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : TextButton(
                                                onPressed: () async {
                                                  //open URL
                                                  final Uri url = Uri.parse(
                                                    snapshot.data!.link,
                                                  );
                                                  if (!await launchUrl(url)) {
                                                    throw Exception(
                                                      'Could not launch $url',
                                                    );
                                                  }
                                                },
                                                child: LimitedBox(
                                                  maxWidth: 180.0,
                                                  child: Text(
                                                    snapshot.data!.link,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.blue.shade900,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    Text(
                                      "Activity:${snapshot.data!.activity}",
                                      style: TextStyle(
                                        color: Colors.pink.shade900,
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                ),
                //api_response --end
              ],
            ),
          ),
        ),
      ),
    );
  }
}
