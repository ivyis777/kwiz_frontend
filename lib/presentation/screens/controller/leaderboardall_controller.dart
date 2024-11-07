import 'package:Kwiz/data/api_service.dart';
import 'package:Kwiz/data/models/leaderboardall_model.dart';
import 'package:get/get.dart';

  

class LeaderboardallController extends GetxController {
  var isLoading = false.obs;
  var leaderboardData = LeaderBoardAllModel().obs;

  void updateLoading(bool load) {
    isLoading.value = load;
    update();
  }

  Future<void> fetchLeaderBoardAll({required String quizId}) async {
    updateLoading(true);

    try {
      final response = await ApiService.LeaderBoardAll(quiz_id: quizId);
      leaderboardData.value = response;
    } catch (e) {
    
      print('Error fetching leaderboard data: $e');
    } finally {
      updateLoading(false);
    }
  }
}
