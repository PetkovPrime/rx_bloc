import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'package:favorites_advanced_base/repositories.dart';

import '../../../base/models/app_state.dart';
import '../../details/redux/actions.dart';
import '../../favorites/redux/actions.dart';
import '../../search/redux/actions.dart';
import 'actions.dart';

Epic<AppState> pickImageEpic(PuppiesRepository repository) =>
    (actions, store) =>
        actions.whereType<ImagePickAction>().switchMap((action) async* {
          try {
            final pickedImage = await repository.pickPuppyImage(action.source);
            if (pickedImage?.path != null) {
              yield ImagePathAction(imagePath: pickedImage!.path);
            }
          } catch (_) {
            //yield PuppiesFetchFailedAction();
          }
        });

Epic<AppState> updatePuppyEpic(PuppiesRepository repository) =>
    (actions, store) =>
        actions.whereType<UpdatePuppyAction>().switchMap((action) async* {
          try {
            yield EditLoadingAction();
            final updatedPuppy =
                await repository.updatePuppy(action.puppy.id, action.puppy);
            yield UpdateSucceededAction();
            yield ModifyDetailsPuppy(puppy: updatedPuppy);
            yield UpdateSearchStatePuppyAction(puppy: updatedPuppy);
            yield UpdateFavoritesStatePuppyAction(puppy: updatedPuppy);
          } catch (error) {
            yield UpdateFailedAction(error: error.toString());
          }
        });
