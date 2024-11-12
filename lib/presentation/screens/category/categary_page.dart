
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:RiddleQing/presentation/screens/SubCategaries/sub_categaries.dart';
import 'package:RiddleQing/presentation/screens/controller/categaries_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../gen/assets.gen.dart';

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

class ChooseCatPage extends StatelessWidget {
  final int? quizTypeId;

  ChooseCatPage({required this.quizTypeId});

  @override
  Widget build(BuildContext context) {
    final categariesController = Get.put<CategariesController>(CategariesController());

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (quizTypeId != null) {
        categariesController.fetchCategories(quizTypeId!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Categary",
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
      body: Obx(() {
        if (categariesController.isLoading.value) {
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
                      child: categariesController.categariesGetList.isEmpty
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
                                  itemCount: categariesController.categariesGetList.length,
                                  itemBuilder: (context, index) {
                                    final quizCategoryId = categariesController.categariesGetList[index].quizCategoryId;

                                    return OutlinedButton(
                                      onPressed: () {
                                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubCategariesPage(quizCategoryId: quizCategoryId)),
            );
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.category, size: 30),
                                          SizedBox(height: 8),
                                          Text(
                                            categariesController.categariesGetList[index].quizCategory ?? "",
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
