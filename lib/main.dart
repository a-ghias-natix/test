import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:magic_ext_solana/magic_ext_solana.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/blockchain/supported_blockchain.dart';

void main() {
  Magic.instance = Magic.blockchain("pk_live_9D0D310062A056D1", rpcUrl: "https://api.mainnet-beta.solana.com", chain: SupportedBlockchain.solana);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Magic.instance.relayer,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            var res = await Magic.instance.auth.loginWithEmailOTP(
                email: "a.ghias@natix.io");
            print(res);
            // I can not get the info of the user which should be logged in here.
            var info = await Magic.instance.user.getInfo();
            print(info);
          } catch (ex) {
            print(ex);
          }
        },
        tooltip: 'Magic Link',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
