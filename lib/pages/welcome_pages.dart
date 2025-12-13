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
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Hello my name is iqbal",
            style: whiteTextStyle.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 51,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(contex).size.width,
            child : ElevatedButton(
              onPressed: (){}, 
              child: Text(
                'Create Account', 
                style:whiteTextStyle.copyWith(
                  fontSize: 20, 
                  fontWeight: FontWeight.w300, 
                  color: primary),
                  ), style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)))
              )
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(contex).size.width,
            child : ElevatedButton(
              onPressed: (){}, 
              child: Text(
                'Loginn', 
                style:whiteTextStyle.copyWith(
                  fontSize: 20, 
                  fontWeight: FontWeight.w300, 
                  color: secondaryColor),
                  ), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary, 
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: secondaryColor, width: 3),
                      borderRadius: BorderRadius.circular(25))))),
          SizedBox(
            height: 30,
          ),
          Text(
          'All Right Reserved @2025',
          textAlign: TextAlign.center,
          style: 
          whiteTextStyle.copyWith(
            color: secondaryColor, fontSize: 11),
            ),
          SizedBox(
            height: defaultMargin,
          ),
        ]
      ),),

    );
  }
}