import 'package:Kwiz/core/colors.dart';
import 'package:Kwiz/gen/assets.gen.dart';
import 'package:Kwiz/gen/fonts.gen.dart';
import 'package:Kwiz/presentation/screens/LatestQuizList/latestquizlist_page.dart';
import 'package:Kwiz/presentation/screens/category/categary_page.dart';
import 'package:Kwiz/presentation/screens/controller/add_categegory_controller.dart';
import 'package:Kwiz/presentation/screens/controller/latestquiz_controller.dart';
import 'package:Kwiz/presentation/screens/controller/profile_controller.dart';
import 'package:Kwiz/presentation/screens/controller/promotioncardlist_controller.dart';
import 'package:Kwiz/presentation/screens/controller/promotions_controller.dart';
import 'package:Kwiz/presentation/screens/controller/promotionsecond_controller.dart';
import 'package:Kwiz/presentation/screens/controller/quiz_subscription_controller.dart';
import 'package:Kwiz/presentation/screens/controller/recent_quiz_controller.dart';
import 'package:Kwiz/presentation/screens/controller/subscription_controller.dart';
import 'package:Kwiz/presentation/screens/controller/types_of_categeries.dart';
import 'package:Kwiz/presentation/screens/controller/upcoming_controller.dart';
import 'package:Kwiz/presentation/screens/controller/user_controller.dart';
import 'package:Kwiz/presentation/screens/controller/wallet_balance_controller.dart';
import 'package:Kwiz/presentation/screens/home/home_constraints.dart';
import 'package:Kwiz/presentation/screens/live_quizes/live_quizes.dart';
import 'package:Kwiz/presentation/screens/notification_screen/notification_screen.dart';
import 'package:Kwiz/presentation/screens/promotioncardonclick/promotionCard.dart';
import 'package:Kwiz/presentation/screens/subscription/subsription_page.dart';
import 'package:Kwiz/presentation/screens/wallet/topup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/storage_manager/local_storage_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late String userId = '';
  int _selectedIndex = 0;
    final UserController userController = Get.find<UserController>();
  
  final quizGetController = Get.put<QuizGetController>(QuizGetController());
  final subscriptionkwizzesController = Get.put<SubscriptionKwizzescontroller>(SubscriptionKwizzescontroller());
  final recentQuizController = Get.put<RecentQuizController>(RecentQuizController());
  final UpcomingKwiizzesController = Get.put<upcomingKwiizzesController>(upcomingKwiizzesController());
  final latestquizcontroller = Get.put<Latestquizcontroller>(Latestquizcontroller());
  final walletBalanceController = Get.put<WalletBalanceController>(WalletBalanceController());
  final quizSubscriptionController = Get.put<QuizSubscriptionController>(QuizSubscriptionController());
  final  quizTypeController = Get.put<TypesOfCategeriesController>(TypesOfCategeriesController());
  final  promotionsController = Get.put<PromotionsController>(PromotionsController());
  final  promotionsecondController = Get.put<PromotionsecondController>(PromotionsecondController());
  final PromotioncardlistController controller = Get.put(PromotioncardlistController() );
  final box = GetStorage();

   bool isLoading = false; 
  late dynamic walletBalance = 0;  
    String? _username;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override

  void initState() {
    super.initState();
  
    promotionsController.PromotionsListApi();
    promotionsecondController.PromotionsecondListApi();
    subscriptionkwizzesController.SubscribedKwiizzesAPI();
    latestquizcontroller.LatestKwiizzesAPI();
    UpcomingKwiizzesController.upcomingKwizzesAPI();
    quizTypeController.TypeCatGetAPI();
    recentQuizController.fetchRecentQuiz(box.read(LocalStorageConstants.userId).toString());
    quizGetController.getQuiz();
       _fetchWalletBalance(); 
    setState(() {
        isLoading = false;
         
      });
     

  }


  void _fetchWalletBalance() async {
    setState(() {
    isLoading = true;
  });
    final userId = box.read(LocalStorageConstants.userId).toString();  
    await walletBalanceController.getWalletBalanceUser(
      context: context,
      user_id: userId,
    );

 
    print("Fetched Wallet Balance: ${walletBalanceController.walletBalanceModel?.walletBalance}");

    setState(() {
    walletBalance = walletBalanceController.walletBalanceModel?.walletBalance ?? 0;
    isLoading = false; 
    print("Fetched Wallet Balance: ${walletBalanceController.walletBalanceModel?.walletBalance}");
    print("Assigned Wallet Balance: $walletBalance");
  });
}
  
  
Widget _buildBox(String title, {int? quizTypeId, required int imageIndex, Color? color, required VoidCallback onTap}) {
  List<String> imagePathList = [
    'assets/images/8.png',
    'assets/images/3.png',
    'assets/images/13.png',
    'assets/images/6.png',
    'assets/images/10.png',
    'assets/images/9.png',
   
  ];

  if (imageIndex < 0 || imageIndex >= imagePathList.length) {
    imageIndex = 0;
  }

  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(   height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: Colours.CardColour, 
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage(imagePathList[imageIndex]),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(), 
          ),
        ),
      ),
      SizedBox(height: 8),
      Flexible(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: FontFamily.rubik,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colours.CardColour,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}



Widget _buildCategories(BuildContext context, List<String> imagePathList) {
  return Obx(() {
    if (quizTypeController.typesCatGetList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          
          crossAxisCount: 3,
          childAspectRatio: 0.9, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: quizTypeController.typesCatGetList.length,
        itemBuilder: (context, index) {
          var quizType = quizTypeController.typesCatGetList[index];
           Color boxColor;
          if (index % 3 == 0) {
            boxColor = Colours.CardColour.withOpacity(0.5);
          } else if (index % 3 == 1) {
            boxColor = Colours.CardColour;
          } else {
            boxColor = Colours.CardColour.withOpacity(1);
          }

          return _buildBox(
            quizType.quizType ?? '',
           quizTypeId:quizType.quizTypeId, 
                imageIndex: imagePathList.length > index ? index : 0,
           
             color: Colours.CardColour,
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseCatPage( quizTypeId:quizType.quizTypeId,))
            );
           
               print(quizType.quizTypeId);
            },
          );
        },
      );
      
    }
  });
}
 Widget _buildSlider(BuildContext context) {
    final PromotioncardlistController promotionCardController = Get.find();
  return CarouselSlider(
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.3,
      autoPlay: true,
      enlargeCenterPage: true,
      aspectRatio: 19 / 10,
      viewportFraction: 1.0,
    ),
    items: [
      Obx(() {
        if (recentQuizController.isLoading.value) {
          return SizedBox.shrink();
        } else {
          final recentQuizData = recentQuizController.recentQuizData.value;
          return _buildSliderCard(
            context,
            title: HomeConstaints.cardtext1,
            content: recentQuizData != null && recentQuizData.quizTitle != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recentQuizData.quizTitle!,
                        style: TextStyle(
                          fontFamily: FontFamily.rubik,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [Text("Score : ", style: TextStyle(
                          fontFamily: FontFamily.rubik,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(width: 20),
                          CircleAvatar(
                            backgroundColor: Colours.onpressedbutton,
                            radius: 22,
                            child: Text(
                              '${recentQuizData.result ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: FontFamily.rubik,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Text(
                    "No recent quiz",
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            backgroundColor: Colours.CardColour,
            
            imagePath: 'assets/images/1.png',
          );
        }
      }),
    Obx(() {
        if (promotionsController.isLoading.value) {
          return SizedBox.shrink();
        } else {
          final promotionData = promotionsController.promotionsClass.value;
          return GestureDetector(
            onTap: () async {
                  String quiz_id = promotionData.quizId.toString();
              await promotionCardController.getPromotionCardList(quiz_id: quiz_id);
              Navigator.push(
              context,
              
              MaterialPageRoute(builder: (context) => PromotionCard(quiz_id: quiz_id),
            )
              );
            },
       child:     _buildSliderCard(
            context,
            title: 'Promotion Quiz',
            content: promotionData != null && promotionData.description != null
                ? Text(
                    promotionData.description!,
                    style: TextStyle(
                      color: Colours.onpressedbutton,
                      fontFamily: FontFamily.rubik,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  )        
                : Text(
                    "No promotions",
                    style: TextStyle(
                        color: Colours.onpressedbutton,
                      fontFamily: FontFamily.rubik,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
             backgroundColor: Colours.CardColour,
            imagePath: 'assets/images/2.png',
          ));
        }
      }),
    Obx(() {
        if (promotionsecondController.isLoading.value) {
          return SizedBox.shrink();
        } else {
          final promotionsecondData = promotionsecondController.PromotionsecondClass.value;
      return GestureDetector(
          onTap: () async {
            String quiz_id = promotionsecondData.quizId.toString();
              await promotionCardController.getPromotionCardList(quiz_id: quiz_id);
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PromotionCard(quiz_id: quiz_id,)),
            );
             
  
 
 
},

          
        child:   _buildSliderCard(
            context,
            title: 'Promotion Quiz',
            content: promotionsecondData != null && promotionsecondData.description != null
                ? Text(
                    promotionsecondData.description!,
                    style: TextStyle(
                        color: Colours.onpressedbutton,
                      fontFamily: FontFamily.rubik,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    "No promotions",
                    style: TextStyle(
                        color: Colours.onpressedbutton,
                      fontFamily: FontFamily.rubik,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
             backgroundColor: Colours.CardColour,
            imagePath: 'assets/images/7.png',
          ));
        }
      }),
    ],
  );
}

Widget _buildSliderCard(
  BuildContext context, {
  required String title,
  required Widget content,
  required Color backgroundColor,
  required String imagePath,
}) {
  return Card(
    margin: EdgeInsets.all(15),
    color: backgroundColor,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: FontFamily.rubik,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                content,
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  );
}
Future<void> _handleRefresh() async {
  setState(() {
    isLoading = true;
  });

  await Future.wait([
    recentQuizController.fetchRecentQuiz(box.read(LocalStorageConstants.userId).toString()),
    subscriptionkwizzesController.SubscribedKwiizzesAPI(),
    latestquizcontroller.LatestKwiizzesAPI(),
    UpcomingKwiizzesController.upcomingKwizzesAPI(),
    quizTypeController.TypeCatGetAPI(),
    quizGetController.getQuiz(),
   
    walletBalanceController.getWalletBalanceUser(
      context: context,
      user_id: box.read(LocalStorageConstants.userId).toString(),
    ),
  ]);

  setState(() {
    walletBalance = walletBalanceController.walletBalanceModel?.walletBalance ?? 0;
    isLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
       final ProfileController _profileController = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: Colours.primaryColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
      
   child:   SingleChildScrollView(
        
           child: Column(
            
             
        children: [
     
         Container(
           margin: EdgeInsets.only(top: 45),
           child: Card(
             elevation: 5.0,
             color: Colours.primaryColor,
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
               child: Container(
            height: MediaQuery.of(context).size.height * 0.16,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
          return CircleAvatar(
            radius: 35,
            backgroundImage: _profileController.profileImageUrl.isNotEmpty
                ? AssetImage(_profileController.profileImageUrl.value)
                : AssetImage(Assets.images.profile.path),
          );
        }),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                       Expanded(
                                          child:  Obx(() {
       
        String displayNameToShow = userController.displayName.value.isNotEmpty
            ? userController.displayName.value
            : userController.username.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' $displayNameToShow',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: Colours.CardColour),
              ),
            ),
          
          ],
        );
      }),
                                        ),
                          GestureDetector(
                            onTap: () {
                                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
                             
                            },
                            child: Icon(
                              Icons.notifications,
                              color: Colours.yellowcolor,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Wallet : ₹$walletBalance",
                  style: TextStyle(
                    fontFamily: FontFamily.rubik,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colours.CardColour,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TopupPage(walletBalance: walletBalance,)),
            );
                 
                  },
                  child: Text(
                    "Top Up",
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colours.CardColour,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(110, 30),
                    backgroundColor: Colours.yellowcolor, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
                   ],
                 ),
               ),
             ),
           ),
         ),


              SizedBox( 
  width: MediaQuery.of(context).size.width * 0.95, 
  height: MediaQuery.of(context).size.height * 0.2,
   child: _buildSlider(context),  

            ),
  Padding(
 padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical:2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Our Kwiizzes',
                      style: TextStyle(
                        fontFamily: FontFamily.rubik,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colours.CardColour,
                      ),
                    ),
                  ),
       Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical:0,),
             child: _buildCategories(context, [
    'assets/images/riddle.png',
    'assets/images/gk.png',
    'assets/images/student.png',
    'assets/images/devotional.png',
    'assets/images/corporate.png',
    'assets/images/event.png',
  ]),)
      ],
    ),
  ),
                      Container(
                       margin: EdgeInsets.only(left: 24, right: 24,bottom: 0),
                       child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      HomeConstaints.title,
                      style: TextStyle(
                          fontSize: 22,
                              color: Colours.CardColour,
                          fontFamily: FontFamily.rubik,
                          fontWeight: FontWeight.w500),
                    ),
                 
                  ],
                
                ),
              SizedBox(height: 5),
                         Column(
                  children: [
                    Card(
                      color: Colours.CardColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0), 
                        side: BorderSide(
                          color: Colours.textColour,
                          width: 0.1,
                        ),
                      ),
                      child:  GestureDetector(
                          onTap: () {
                             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LiveQuizPage()),
            );
                          },
                child: Obx(() {
            if (UpcomingKwiizzesController.isLoading.value) {
    return Center(child: CircularProgressIndicator());
  } { return Column(
                  
                    children: [
                      
                      ListTile(
                        
                        title: Center(
                          child: Text(  UpcomingKwiizzesController
                                                      .upcomingKwizzesClass.value?.title ??
                                                  "",style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 18,
                              color: Colours.black,
                              fontWeight: FontWeight.w600),),
                        ),
                        subtitle: Center(
                          child: Text( UpcomingKwiizzesController
                                                      .upcomingKwizzesClass.value?.message ??
                                                  "",style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 16,
                              color: Colours.textColour,
                              fontWeight: FontWeight.w500),),
                        ),
                        leading: Image.asset(
  Assets.images.cardimage4.path,),
                              
                                            trailing:Icon(Icons.arrow_forward_ios,size: 20,color: Colours.primaryColor,),
                      ),
                       
                    
                    ],
                    
                );}
            }
                  
                ),
                
                      ),
                        ) ]),
                      SizedBox(height: 5),
                         Column(
                  children: [
                    Card(
                      color: Colours.CardColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0), 
                        side: BorderSide(
                          color: Colours.textColour,
                          width: 0.1,
                        ),
                      ),
                       child:  GestureDetector(
                          onTap: () {
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LatestQuizListPage()),
            );
                          },
                      
                child: Obx(() {
            if (latestquizcontroller.isLoading.value) {
    return Center(child: CircularProgressIndicator());
  } { return Column(
                  
                    children: [
                      
                      ListTile(
                        
                        title: Center(
                          child: Text(  latestquizcontroller
                                                      .LatestquizClass.value?.title ??
                                                  "",style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 18,
                              color: Colours.black,
                              fontWeight: FontWeight.w600),),
                        ),
                        subtitle: Center(
                          child: Text(  latestquizcontroller
                                                      .LatestquizClass.value?.message ??
                                                  "",style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 16,
                              color: Colours.textColour,
                              fontWeight: FontWeight.w500),),
                        ),
                        leading: Image.asset(
  Assets.images.cardimage4.path,),
                              
                                            trailing:Icon(Icons.arrow_forward_ios,size: 20,color: Colours.primaryColor,),
                      ),
                       
                    
                    ],
                    
                );}
            }
                  
                ),
                
                      ),
                       )]),
                      
                         Column(
                  children: [
                    Card(
                      color: Colours.CardColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0), 
                        side: BorderSide(
                          color: Colours.textColour,
                          width: 0.1,
                        ),
                      ),
                   child:  GestureDetector(
                          onTap: () {
                           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubscriptionPage()),
            );
                          },
                child: Obx(() {
            if (subscriptionkwizzesController.isLoading.value) {
    return Center(child: CircularProgressIndicator());
  } { return Column(
                  
                    children: [
                      
                      ListTile(
                        
                        title: Center(
                          child: Text(  
                                                 subscriptionkwizzesController.SubscribedkwizzesClass.value?.title ??
                                                  "",style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 18,
                              color: Colours.black,
                              fontWeight: FontWeight.w600),),
                        ),
                        subtitle: Center(
                          child: Text(  subscriptionkwizzesController
                                                      .SubscribedkwizzesClass.value?.message ??
                                                  "",style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 16,
                              color: Colours.textColour,
                              fontWeight: FontWeight.w500),),
                        ),
                        leading: Image.asset(
  Assets.images.cardimage4.path,),
                              
                                            trailing:Icon(Icons.arrow_forward_ios,size: 20,color: Colours.primaryColor,),
                      ),
                       
                    
                    ],
                    
                );}
            }
                  
                ),
                
                      ),
                
                      ),
                         ])
                       
              ],
                       ),
                       
                     ),
                     
                   
                 
               ],
             ),
           
        
        )),
      
                        
                      
                
              
          
floatingActionButton: FloatingActionButton(
  onPressed: () {
    showDialog(
         barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colours.CardColour,
          content: Text(
            HomeConstaints.popuptext3,
            style: TextStyle(
              fontFamily: FontFamily.rubik,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colours.primaryColor,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                    
                  },
                  child: Text(
                    HomeConstaints.popuptext5,
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colours.CardColour,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primaryColor, 
                  ),
                ),
                SizedBox(width: 10), 
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                    showDialog(
                         barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colours.CardColour,
                          content: Text(
                            "Wow! Thanks for applying for the creator role our  team will connect with  you shortly Thanks",
                            style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colours.primaryColor,
                            ),
                          ),
                          actions: <Widget>[
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                   Navigator.of(context).pop(); 
                                },
                                child: Text("Done", style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colours.CardColour,
                    ),),
                                style: ElevatedButton.styleFrom(
                                  
                                  backgroundColor: Colours.primaryColor, 
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    HomeConstaints.popuptext4,
                    style: TextStyle(
                      fontFamily: FontFamily.rubik,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colours.CardColour,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  },
  child: Icon(Icons.add,color: Colours.primaryColor,),
  backgroundColor: Colours.CardColour,
  shape: CircleBorder(), 
),


    );
  }
}
String? retrieveUsername() {
  final box = GetStorage();
  return box.read(LocalStorageConstants.username);
}
