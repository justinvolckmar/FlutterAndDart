import 'package:flutter/material.dart';

//The initial function that is called on application execution.
void main() {
  //Instantiate the MyApp class
  runApp(MyApp());
}

//MyApp is a StatelessWidget, meaning it does not have it's own state,
//and requires an override on the build function.
class MyApp extends StatelessWidget {
  //The build function returns a Widget to display on the application screen
  @override Widget build(BuildContext context) {
    return MaterialApp( //The top-level application design containing theme data and navigation pages
      title: 'Flutter Demo',
      theme: ThemeData( //The theme can be used across widgets to sync colors to specific Widget types.
        primarySwatch: Colors.blue, //Swatches are a palette of a MaterialColor, where Colors.blue is a MaterialColor
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(), //The home: is the call to a widget to be built and displayed to the user.
      // routes: <String,WidgetBuilder>{
      //  //Routes are defined within the MaterialApp page and will be used for navigation.
      //  //Navigation will not be covered in the basic widgets application.
      // },
    );
  }
}

//HomePage is a Stateful Widget which requires an override to the state of the class itself.
class HomePage extends StatefulWidget {
  //The HomePage is instantiated with super(key: key) to position it's location
  //in the build-tree correctly, this is a default and is not required, but could be used for customization.
  HomePage({Key key}) : super(key: key);

  @override _HomePageState createState() => _HomePageState();
}

//The state of the HomePage class, requires a build function to display content to the user.
class _HomePageState extends State<HomePage> {

  @override Widget build(BuildContext context) {
    //Scaffolds are the skeleton of many flutter applications pages
    return Scaffold(
      //An appbar is the top navigation bar on flutter apps,
      //usually containing a title, or clickable buttons to switch between windows
      appBar: AppBar(
        //A text object takes in a string and displays it to the user, can be modified with style: TextStyle().
        title: Text("Basic Widgets"),
      ),
      //The body of the scaffold is the main content within the page
      body: //the content of a widget is not required to be in-line
        //A Column contains a list of children that are organized VERTICALLY
        Column( //By default, a column is alligned to the top of it's parent widget.
          children: <Widget>[ //<Widget> is optional, and is used for the trailing // <Widget>[] after the closing ],
            //A Row contains a list of children that are organzied HORIZONTALLY
            Row( //By default, a row is alligned to the left of it's parent widget.
              children: [ //Notice <Widget> is not stated, as it is not required.
                //Icons require an IconData object
                //IconData are predefined as Icons.<icon-name>, and can be wrapped in stateful objects
                //for event-handling purposes.
                Icon(Icons.workspaces_filled), //This icon will do nothing when clicked.
                //Containers are common widgets used in the build tree to format their child object, and space around it.
                Container(
                  //Margin is the spacing around an object, where 5 pixels will be placed around the container object
                  margin: EdgeInsets.all(5),
                  //Padding is the spacing within the object and it's child, where 10 pixels will be placed
                  //between the container and it's child.
                  padding: EdgeInsets.all(10),
                  //Both the width and height of a container can be optionally defined, or the container will
                  //attempt to fill the space around it's parent if not defined.
                  //width: 100,
                  //height: 100,
                  //Containers can have their own styles and customization through the decoration parameter.
                  decoration: BoxDecoration(
                    //You can define the border around the container to have custom specifications.
                    border: Border.all(width: 2, color: Colors.black),
                    //You can also define the edges or corners of each container to be rounded
                    //using BorderRadius.circular(<radius>)
                    borderRadius: BorderRadius.circular(12),
                    //If the decoration is defined and you require a background color on the container,
                    //the color of the container must be defined within the decoration object.
                    //color: Colors.orange,
                  ),
                  //The color of the container can be defined outside the decoration if there is no decoration object.
                  //color: Colors.orange,
                  child: Center( //The Center object positions it's child within the center of it's parent object
                    child: Text("Hello World"), // Notice "Hello World" will appear in the middle of the container.
                  ),
                ),
                //An IconButton contains both an icon to display, as well as a stateful press-listener on the icon.
                IconButton(
                  //When the button is clicked, the OnPressed handler will be envoked.
                  onPressed: () {
                    //The function to be called when the click handler is envoked.
                    MyPressFunction();
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Text("This is within the Column, but outside the Row"),
          ],
        ),
    );
  }

  //void does not require a return statement
  void MyPressFunction() {
    //prints to the console for debug purposes, a phone without a code editing environment will not display this message.
    print("Hello World");
  }


}
