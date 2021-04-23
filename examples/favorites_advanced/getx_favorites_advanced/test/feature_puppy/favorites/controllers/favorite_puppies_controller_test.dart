import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:favorites_advanced_base/repositories.dart';

import 'package:getx_favorites_advanced/base/controllers/mediator_controller.dart';
import 'package:getx_favorites_advanced/feature_puppy/favorites/controllers/favorite_puppies_controller.dart';

import '../../../stubs.dart';
import 'favorite_puppies_controller_test.mocks.dart';

@GenerateMocks([
  PuppiesRepository,
])
void main() {
  late MockPuppiesRepository mockRepo;
  late MediatorController mediatorController;
  late FavoritePuppiesController controller;

  setUp(() {
    mockRepo = MockPuppiesRepository();
    mediatorController = Get.put(MediatorController());
    when(mockRepo.getFavoritePuppies())
        .thenAnswer((_) async => Stub.emptyPuppyList);
    controller =
        Get.put(FavoritePuppiesController(mockRepo, mediatorController));
  });

  tearDown(() {
    Get.delete<MockPuppiesRepository>();
  });

  group('FavoritePuppiesController - ', () {

    test('initialization', () async {
      //assert
      expect(controller.count, 0);
      //arrange
      reset(mockRepo);
      when(mockRepo.getFavoritePuppies())
          .thenAnswer((_) async => throw Stub.testErr);
      //action
      await controller.onReload();
      //assert
      expect(controller.status.isError, true);
      //arrange
      reset(mockRepo);
      when(mockRepo.getFavoritePuppies())
          .thenAnswer((_) async => Stub.puppiesTestUpdated);
      // action
      await controller.onReload();
      final puppiesCount = controller.favoritePuppiesList.length;
      // assert
      expect(puppiesCount, 1);
    });

    test('updateFavoritePuppies', () async {
      //arrange
      reset(mockRepo);
      when(mockRepo.getFavoritePuppies())
          .thenAnswer((_) async => Stub.puppiesTestUpdated);
      await controller.onReload();
      expect(controller.count, 1);
      final puppy = controller.favoritePuppiesList.first;
      expect(puppy.isFavorite, isTrue);
      expect(puppy, Stub.puppyTestUpdated);
      //arrange
      final updatedPuppy = Stub.puppyTest;
      //action
      mediatorController.puppyUpdated(updatedPuppy);
      final count = controller.count;
      //assert
      expect(count, 0);
    });
    test('updateFavoritePuppies - unfavorite puppy', () async {
      //arrange
      final updatedPuppy = Stub.puppyTestUpdated;
      //action
      mediatorController.puppyUpdated(updatedPuppy);
      final count = controller.count;
      //assert
      expect(count, 1);
      final puppy = controller.favoritePuppiesList.first;
      expect(puppy.isFavorite, isTrue);
    });
  });
}
