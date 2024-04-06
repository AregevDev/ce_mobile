import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text(
                'CE Mobile',
                style: TextStyle(fontSize: 64),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () => ScaffoldMessenger.of(context)
                                .showMaterialBanner(MaterialBanner(
                                    content: const Text("Hi"),
                                    actions: [
                                  TextButton(
                                      onPressed: () =>
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentMaterialBanner(),
                                      child: const Text("Bye"))
                                ])),
                        label: const Text("Create a New Workspace")),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.link),
                        onPressed: () => ScaffoldMessenger.of(context)
                                .showMaterialBanner(MaterialBanner(
                                    content: const Text("Hi"),
                                    actions: [
                                  TextButton(
                                      onPressed: () =>
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentMaterialBanner(),
                                      child: const Text("Bye"))
                                ])),
                        label: const Text("Import from Link")),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
