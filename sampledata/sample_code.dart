
/*
class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  //Class-Properties
  bool flag = false;
  ThemeData _theme = lightTheme;


  //Light-Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.lightBlue,
  );


  //Dark-Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color : Colors.deepOrange,
    ),
    primarySwatch: Colors.deepOrange,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ),
  );


  //Function-to-set-Theme
  void setTheme(){
    setState(() {
      flag = !flag;
      if(flag)
        {
          _theme = darkTheme;
        }
      else
        {
          _theme = lightTheme;
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        //statusBarIconBrightness: Brightness.light,
        //systemNavigationBarIconBrightness: Brightness.light,
        //statusBarBrightness: Brightness.light,
      ),
      child: MaterialApp(
        title: 'My-Accountant',
        theme: _theme,
        initialRoute: '/',
        routes: <String,WidgetBuilder>
        {
          "/" : (context) => const MyHomePage(title: "My Home Page"),
          "1" : (context) => const Screen(title: "1"),
          "0" : (context) => const Screen(title: "0")
        },
        //MyHomePage(title: "Home Page",themeFunction: setTheme),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isVisible = !(false);

  void _incrementCounter() {
    setState(() {
      //widget.themeFunction();
      _isVisible = !_isVisible;
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: (){
                  String numString = (_counter%2).toString();
                  Navigator.pushNamed(context, numString);
            },
                child: const Text('You have pushed the button this many times:',
                  style: TextStyle(
                  color: Colors.black
                ),)
            ),
            Text('$_counter', style: Theme.of(context).textTheme.headline4,)
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Theme.of(context).iconTheme.color)
            //Theme.of(context).colorScheme.copyWith(secondary: Theme.of(context).iconTheme.color),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

 */


/*

-FACEBOOK-LOGIN

Padding(
              padding: const EdgeInsetsDirectional.all(7.5),
              child: SizedBox(
                  width: lengthOfSubmitButton(context),
                  height: heightOfSubmitButton(context),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent, // sets background color
                      ),
                      onPressed: (){
                        submit(context);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.all(2),
                            child: Icon(Icons.facebook),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.all(2),
                              child: Text('Login in with your Facebook'))
                        ],
                      ))),
            ),


 -APPLE-LOGIN

 Padding(
              padding: const EdgeInsetsDirectional.all(7.5),
              child: SizedBox(
                  width: lengthOfSubmitButton(context),
                  height: heightOfSubmitButton(context),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // sets background color
                      ),
                      onPressed: (){
                        submit(context);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.all(2),
                            child: Icon(Icons.apple_sharp),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.all(2),
                              child: Text('Login in with your AppleID'))
                        ],
                      ))),
            )

 */