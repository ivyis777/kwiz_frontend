
import 'package:RiddleQing/data/api_service.dart';
import 'package:RiddleQing/data/models/weeklyleader_model.dart';
import 'package:get/get.dart';

  

class WeeklyleaderboardController extends GetxController {
  var isLoading = false.obs;
  var weeklyleaderboardData = weeklyLeaderBoardModel().obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<void> fetchweeklyLeaderBoardAll({required String user_id}) async {
    updateLoading(true);

    try {
      final response = await ApiService.WeeklyLeaderBoard(user_id: user_id);
       weeklyleaderboardData.value = response;
    } catch (e) {
      // Handle error
      print('Error fetching leaderboard data: $e');
    } finally {
      updateLoading(false);
    }
  }
}