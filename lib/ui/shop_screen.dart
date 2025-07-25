import 'package:flutter/material.dart';

import 'components/delegate/sticker_header_delegate.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  Widget _topSection() {
    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 10,
        children: [
          // title / point
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Pay at merchant'), Text('1,200')],
          ),
          // search box
          TextFormField(
            decoration: InputDecoration(fillColor: Colors.grey, filled: true),
          ),
          SizedBox(
            height: 66,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
                Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                  child: Icon(Icons.ac_unit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mainSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Flash Deal"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 256,
          width: double.infinity,
          color: Colors.red,
        ),
        Text("Special Deal"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 256,
          width: double.infinity,
          color: Colors.red,
        ),
        Text("Special Deal 1"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 256,
          width: double.infinity,
          color: Colors.red,
        ),
        Text("Special Deal 2"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 256,
          width: double.infinity,
          color: Colors.red,
        ),
        Text("Special Deal 3"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 256,
          width: double.infinity,
          color: Colors.red,
        ),
        Text("Special Deal 4 "),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 256,
          width: double.infinity,
          color: Colors.red,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: [
              PinnedHeaderSliver(child: _topSection()),
              SliverToBoxAdapter(child: _mainSection()),
            ],
          ),
        ),
      ),
    );
  }
}
