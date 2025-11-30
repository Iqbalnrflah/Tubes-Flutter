part of 'pages.dart';

class WelcomePages extends StatelessWidget {
  const WelcomePages ({Key? key}) : super (key: key);

  @override 
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(bottom: false,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          Image.asset('assets/image', height:333, fit: BoxFit.fill),
          SizedBox(
            height: 15,
          ),
          Text(
            "Welcome",
            style: dangerTextStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "lorem ipsum",
            style: whiteTextStyle.copyWith(fontSize: 28),
          ),
          SizedBox(
            height: 51,
          ),
        ],
      ),),

    );
  }
}