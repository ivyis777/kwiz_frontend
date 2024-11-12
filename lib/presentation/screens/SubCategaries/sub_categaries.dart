
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/gen/assets.gen.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/controller/subcategaries_controller.dart';
import 'package:RiddleQing/presentation/screens/quizzes%20List/quizzes_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryItem {
  final String title;
  final IconData icon;
  final Function onPressed;
 

  CategoryItem({
    required this.title,
    required this.icon,
    required this.onPressed,
  
  });
}          

class SubCategariesPage extends StatelessWidget {
  final int?  quizCategoryId;

  SubCategariesPage ({required this. quizCategoryId});

  @override
  Widget build(BuildContext context) {
    final subcategariesController = Get.put<SubcategariesController>(SubcategariesController());

     WidgetsBinding.instance?.addPostFrameCallback((_) {
      if ( quizCategoryId != null) {
       subcategariesController.fetchCategories( quizCategoryId!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
         "Choose Sub-Categary" ,
          style: TextStyle(
            color: Colours.CardColour,
            fontFamily: FontFamily.rubik,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colours.CardColour,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colours.CardColour,
          size: 25,
        ),
        backgroundColor: Colours.primaryColor,
      ),
      backgroundColor: Colours.primaryColor,
      body:  Obx(() {
        if (subcategariesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: subcategariesController.SubcategariesGetList.isEmpty
                          ? Center(child: Image.asset(Assets.images.workonit.path))
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                var crossAxisCount = 2;
                                if (constraints.maxWidth > 600) {
                                  crossAxisCount = 3;
                                }
                                if (constraints.maxWidth > 900) {
                                  crossAxisCount = 4;
                                }

                                return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2.2,
                                  ),
                                  itemCount: subcategariesController.SubcategariesGetList.length,
                                  itemBuilder: (context, index) {
                                    final quizSubCategoryId = subcategariesController.SubcategariesGetList[index].quizSubCategoryId;

                                    return OutlinedButton(
                                      onPressed: () {
                                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizListPage(quizSubCategoryId: quizSubCategoryId)),
            );
                                      
                                        print(quizSubCategoryId);
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.category, size: 30),
                                          SizedBox(height: 8),
                                          Text(
                                            subcategariesController.SubcategariesGetList[index].quizSubCategory ?? "",
                                            style: TextStyle(
                                              color: Colours.primaryColor,
                                              fontFamily: FontFamily.rubik,
                                              fontSize: 16, 
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 4),
                                        ],
                                      ),
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(
                                          Colours.primaryColor,
                                        ),
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(MaterialState.pressed)) {
                                              return Colours.onpressedbutton;
                                            }
                                            return Colours.secondaryColour;
                                          },
                                        ),
                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
