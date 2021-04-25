

import 'package:flutter_test/flutter_test.dart';
import 'package:gitfeed/model/auth.dart';
import 'package:gitfeed/screen/profile/profile_model.dart';

import '../../testDoubles/worker/auth_worker_spy.dart';

main() {

  ProfileModel sut;
  AuthWorkerSpy authWorker;

  setUp(() {
    authWorker = AuthWorkerSpy();
    sut = ProfileModel(authWorker);
  });
  
  Auth authStub() {
    return Auth(
      login: "Geektree0101",
      id: 1239953,
      profileImageURL: "https://test.jpg",
      name: "David Ha",
      company: "Karrot.inc",
      followers: 100,
      following: 200
    );
  }
  test("reload on success", () async {
    // given
    authWorker.getMeStub = Future<Auth>.value(authStub());

    // when
    await sut.reload();

    // then: worker
    expect(authWorker.getMeCalled, 1);

    // then: view model
    expect(sut.contentViewModel.company, "Karrot.inc");
    expect(sut.contentViewModel.profileImageURL, "https://test.jpg");
    expect(sut.contentViewModel.username, "Geektree0101");
    
    expect(sut.engagementViewModel.followerCount, 100);
    expect(sut.engagementViewModel.followingCount, 200);
  });
}