import 'package:captura_lens/user/user_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UserEventBooking extends StatefulWidget {
  const UserEventBooking({super.key});

  @override
  State<UserEventBooking> createState() => _UserEventBookingState();
}

class _UserEventBookingState extends State<UserEventBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: CupertinoColors.white,
        ),
        backgroundColor: CupertinoColors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: CupertinoColors.black,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Book Your Event',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: CupertinoColors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Address',
                        border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Event Name',
                          border: OutlineInputBorder()),
                    ),
                  const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Duration',
                          border: OutlineInputBorder()),
                    ),
                  const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Type of Photography',
                          border: OutlineInputBorder()),
                    ),
                  const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'From Date',
                          border: OutlineInputBorder()),
                    ),
                  const SizedBox(height: 20.0),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'To Date',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                          hintText: 'Contact Number',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.white,
                          backgroundColor: CustomColors.buttonGreen),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserCategories()));
                      },
                      child: Text('Book'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
