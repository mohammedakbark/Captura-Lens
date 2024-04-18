import 'package:captura_lens/constants.dart';
import 'package:captura_lens/photographer/photo_event_registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoEventDetails extends StatefulWidget {
  const PhotoEventDetails({super.key});

  @override
  State<PhotoEventDetails> createState() => _PhotoEventDetailsState();
}

class _PhotoEventDetailsState extends State<PhotoEventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                decoration: BoxDecoration(
                    color: CupertinoColors.darkBackgroundGray,
                    border: Border.all(color: CupertinoColors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey,),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Heading", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                      Text("Details of the contest", style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Heading of the Event ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                    style: TextStyle(color: CupertinoColors.white, fontSize: 15),
                  )
                ])),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhotoEventRegistration()));
                },
                style:
                    TextButton.styleFrom(backgroundColor: CustomColors.buttonGrey),
                child: const Text(
                  "Participate",
                  style: TextStyle(
                    color: CustomColors.buttonTextGrey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
