// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:api/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../Helpers/AppNavigations/NavigationMixin.dart';
import '../../Helpers/Mixins/Popup.dart';
import '../../Helpers/Mixins/Textfield.dart';
import 'FirstPageVM.dart';

// Create a class FirstPage that extends StatefulWidget
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.extraData}) : super(key: key);
  final Object extraData;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Create an instance _FirstPageVM for the class FirstPageVM
  final FirstPageVM _FirstPageVM = FirstPageVM();

  // Create an instance _controller for class TextEditingController
  final TextEditingController _controller = TextEditingController();

  // Create a initState of type void
  @override
  void initState() {
    // refer it to the parent's initState method
    super.initState();

    // Trigger the method fetchAllAvengers using the instance of FirstPageVM
    _FirstPageVM.fetchAllAvengers();

    // Listen to the stream of the Textfieldcontroller
    _FirstPageVM.Textfieldcontroller.stream.listen(
      (event) {
        // Check if the event is AddTextfield
        if (event is AddTextfield) {
          // If so, provide the text length of the controller as offset to the selection
          _controller.selection =
              TextSelection.collapsed(offset: _controller.text.length);
        }
      },
    );

    // Listen to the stream of the popupcontroller
    _FirstPageVM.popupcontroller.stream.listen((event) {
      // Check if the event is AddText
      if (event is AddText) {
        // Create a switch case and the first index of list data of the event as expression
        switch (event.data[1]) {
          // If the message is showpop trigger the method popUpuserInput and set the controller's text empty
          case "showpopup":
          _controller.text = "";
            popUpuserInput();
            break;

          // If the message is popupaction trigger the method popUpActions and pass the zeroth index of data of the event to the index parameter.
          // During edit method, the text present in the controller needs to be displayed so for that assign the name of that particular index in AllAvengers list to the controller's text
          case "popupaction":
            _controller.text = _FirstPageVM.allAvengers[event.data[0]].name!;
            popUpActions(index: event.data[0]);
            break;
        }
      }
    });

    // Listen to the stream of the INavigation Streamcontroller
    _FirstPageVM.navigationStream.stream.listen((event) {
      // Check if the event is NavigatorPop
      if (event is NavigatorPop) {
        // If so, pop the event's data in the context
        context.pop(data: event.data, checkMounted: event.checkMounted);
      }
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(

        // In the Onpressed method, trigger the method showpop and clear the controller as the controller's data should not be displayed in the textfield
        onPressed: () {
          _FirstPageVM.showpop();
        },
        child: const Icon(Icons.add_rounded),
      ),
      appBar: AppBar(
        title: const Text("AVENGERS"),
      ),
      body: Column(
        children: [
          Observer(
            builder: (context) {
              return Visibility(
                // Inside the visibility widget, if isAvengersLoading is false display the linear progress indicator
                visible: _FirstPageVM.isAvengersLoading,
                child: const LinearProgressIndicator(),
              );
            },
          ),
          Expanded(
            child: Observer(builder: (context) {
              return Visibility(
                //Inside the visibility widget, if isAvengersLoading is true display the Listview
                visible: !_FirstPageVM.isAvengersLoading,

                child: ListView.builder(
                  // Specifify the length of the list allAvengers to the itemcount of the list view builder
                  itemCount: _FirstPageVM.allAvengers.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading:
                          // In the leading of the listTile display the id of that particular element in the index of list allAvengers and typecast it to string
                          Text(_FirstPageVM.allAvengers[index].id.toString()),

                      // In the title display the name of that particular element in the index of list allAvengers if its empty assign an empty string
                      title: Text(_FirstPageVM.allAvengers[index].name ?? ""),
                      trailing: SizedBox(
                        width: 100,
                        height: 50,
                        child: Row(
                          children: [
                            IconButton(
                              // When the edit icon is clicked, trigger the showsecondpop method and pass the listview index to the parameter index
                              onPressed: () =>
                                  _FirstPageVM.showsecondpop(index: index),
                              icon: const Icon(Icons.edit),
                              color: Colors.green,
                            ),
                            IconButton(
                              onPressed: () =>
                                  // When the delete icon is clicked, trigger the deleteHero method and pass the listview index to the parameter index
                                  _FirstPageVM.deleteHero(index: index),
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Create a method popUpuserInput that returns AlertDialog
  void popUpuserInput() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
              width: 200,
              height: 100,
              child: TextFormField(
                // In the controller parameter of TextFormfield pass the _controller
                controller: _controller,
                onChanged:_FirstPageVM.onchange,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  label: const Text("Hello hero!"),
                  hintText: "Enter the name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  constraints:
                      const BoxConstraints(maxHeight: 80, maxWidth: 400),
                ),
              )),
          actions: [
            ElevatedButton(
                // If the cancel button is clicked, trigger the cancelInput method
                onPressed: _FirstPageVM.cancelInput,
                child: const Text("Cancel")),
            ElevatedButton(
                // If the elevated button is pressed trigger the method addHero and pass the text of the controller to the parameter nameofhero
                onPressed: () {
                  _FirstPageVM.addHero(nameofhero: _controller.text);
                },
                child: const Text("Save")),
          ],
        );
      },
    );
  }

  // Create a method popUpActions which returns alert dialog, it has index as the required parameter
  void popUpActions({required int index}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
              width: 200,
              height: 100,
              // Inside the alert box display the particular data in the index of the list value
              child: TextFormField(
                controller: _controller,
                onChanged:_FirstPageVM.onchange,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  label: const Text("Hello Hero!"),
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  constraints:
                      const BoxConstraints(maxHeight: 80, maxWidth: 400),
                ),
              )),
          actions: [
            ElevatedButton(
                // If the cancel button is clicked, trigger the cancelInput method
                onPressed: _FirstPageVM.cancelInput,
                child: const Text("Cancel")),
            ElevatedButton(

                // If the elevated button is pressed trigger the method editHero and pass the text of the controller to the parameter nameofhero and index to the index parameter
                onPressed:()async => await
                  _FirstPageVM.editHero(
                      index: index, nameofhero: _controller.text)
                ,
                child: const Text("Save")),
          ],
        );
      },
    );
  }
}
