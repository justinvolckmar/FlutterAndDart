import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override _HomePageState createState() => _HomePageState();
}

//See basic_widgets for information on initializing the main application.
//We'll now assume you understand the basics of some of the explained widgets in flutter.
//Any further information you may require is provided by flutter documentation
//at https://api.flutter.dev/index.html

//extends is used to define an object in terms of another object,
//where _HomePageState inherits and requires the method override of State (build(BuildContext context))
class _HomePageState extends State<HomePage> {

  //We'll define a boolean value for the controlling the state of the icon.
  //This is declared at a global scope so it could be accessed within any method in the State of HomePage.
  //If the function for favouriting was more complex, it could be placed in it's own function and called.
  bool isFavourite = false;

  //define the total number of favourites to be adjusted on click.
  int totalFavourites = 17;

  //create a text controller for the TextField, initalized/instantiated below.
  TextEditingController _controller;

  //Called when the homepage is being built initially, used to define variables before
  //loading the build-tree.
  @override initState() {
    //instantiate the text editing controller for use in the TextField.
    _controller = TextEditingController();
    //call the super function to reference of the State<HomePage>,
    //super references the object or widget represented by the extends clause.
    super.initState();
  }

  @override Widget build(BuildContext context) {
    //We'll define a local icon that will be adjusted according to a boolean value.
    IconData local;
    if (isFavourite) {
      local = Icons.star;
    } else {
      local = Icons.star_border;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Interactivity"),
      ),
      body:
      //ListViews default to Vertical aligment, but can also have Horizontal alignment if defined.
      //ListViews are similar to Columns and Rows, but they can be scrolled to view more information then
      //first avaliable on the application page.
      ListView(
        //Columns and Rows can contain alignments for both their main and cross axises.
        //This determines where their children will be built on screen.
        children: <Widget>[
          //There are multiple types of image instantiation
          //the easiest to implement being asset, where a pre-defined image will be rendered
          //useful for loading sprites if you want objects for a game to have a specific texture.
          //image.jpg from https://unsplash.com/photos/tBL-6z44eHs
          Image.asset('assets/image.jpg'), //must also define assets in pubspec.yaml
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //You can define a texts style to customize lots of features such as
              //the weighting (bold), the font used, font size, and font color.
              Text("@username", style: TextStyle(fontWeight: FontWeight.w600)),
              Text("FirstName LastName"),
              //Rows can be nested within eachother to define different alignments.
              Row(
                //center will group children together at the middle of it's parent layout.
                //ie the middle of the 3rd widget in spaceEvenly.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //create an InkWell to control the onPressed handler of the icon.
                  //You cannot use an IconButton because an IconButton is a StatelessWidget, and will not be updated.
                  InkWell(
                    //notice InkWells use onTap, which is equivalent to onPressed of an IconButton.
                    onTap: () {
                      //We'll set the state as such so the widget tree knows to rebuild on pressed.
                      setState(() {
                        if (isFavourite) {
                          totalFavourites -= 1; //Unfavourite the image, removing 1 from favourites count.
                        } else {
                          totalFavourites += 1; //Favourite the image, adding 1 to total favourites.
                        }
                        //Invert the boolean state used to determine the IconData.
                        isFavourite = !isFavourite;
                      }); //end of setState
                    },
                    //reference the local icondata in the icon object.
                    child: Icon(local, color: Colors.red),
                  ),
                  //Display the total favourites to the user.
                  Text(totalFavourites.toString()),
                ],
              ),
            ],
          ),
          //outside both rows, inside the listview
          //define a textfield for the user to input text.
          TextField(
            //define the controller as instanitated in the initState function
            //so the application knows which variable to save the modified text to.
            controller: _controller,
            //define the max amount of lines the textfield can have.
            maxLines: 1,
            //on Enter pressed, the onEditingComplete function will be called,
            //assuming the current line == maxlines
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
            //define input decoration so the textfield can contain hint text.
            decoration: InputDecoration(
              //define the string that will be displayed when there is no text in the textfield.
                hintText: 'Enter text here!'
            ),
          ),
          //The builder object is required to decouple the textbutton from the context of the scaffold
          //Snackbars cannot be displayed if their calling reference has the same buildcontext as the
          //scaffold in the build-tree hierarchy.
          Builder(builder: (BuildContext context) {
            //A TextButton is similar to an IconButton, where it's state cannot be changed,
            //but can be used to update other state changes.
            return TextButton(
              child: Text("Show Snackbar", style: TextStyle(color: Colors.black, backgroundColor: Colors.grey)),
              onPressed: () {
                callSnackBar(context);
              },
            );
          }),
        ],
      ),
    );
  }

  //We'll pass the current build context to the function so the scaffold reference
  // does not try to use the global state context.
  void callSnackBar(BuildContext context) {
    //Referencing the scaffold that is linked to the current build context
    Scaffold.of(context).showSnackBar(
      //Create a snackbar to appear at the bottom of the page with the controllers text.
      SnackBar(
        //the content of the snackbar is commonly text, but can contain other widgets.
        //though uncommon, you could require the snackbar to be dismissed by an action button.
        content: Text(_controller.value.text),
        //duration can be optionally defined to control the length of time the snackbar appears for
        //if undefined, the application will default to a pre-defined value.
        duration: Duration(seconds: 2),
      ),
    );
  }
}
