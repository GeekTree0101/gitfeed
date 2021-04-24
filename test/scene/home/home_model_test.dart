

import 'package:flutter_test/flutter_test.dart';
import 'package:gitfeed/model/owner.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import '../../testDoubles/worker/repositort_worker_spy.dart';

void main() {

  HomeModel sut;

  RepositoryWorkerSpy repositoryWorker;

  setUp(() {
    repositoryWorker = RepositoryWorkerSpy();
    sut = HomeModel(repositoryWorker);
  });
  
  Repository dummyRepository(int id) {
    return Repository(
      id: id,
      name: "name",
      fullName: "fullName",
      description: "description",
      owner: Owner(
        username: "Geektree0101",
        profileImageURL: "https://test.jpg"
      )
    );
  }

  test("reload", () async {
    // given
    repositoryWorker.fetchListStub = Future<List<Repository>>.value([dummyRepository(1)]);
    
    // when
    await sut.reload();
    
    // then: worker
    expect(repositoryWorker.fetchListCalled, 1);

    // then: model
    expect(sut.items.length, 1);
  });

  test("should failed to next call", () async {
    // given
    repositoryWorker.fetchListStub = Future<List<Repository>>.value([dummyRepository(1)]);
    
    // when
    await sut.next();
    
    // then: worker
    expect(repositoryWorker.fetchListCalled, 0);

    // then: model
    expect(sut.items.length, 0);
  });

  test("should success to next call", () async {
    // given
    repositoryWorker.fetchListStub = Future<List<Repository>>.value([dummyRepository(1)]);
    await sut.reload();
    repositoryWorker.fetchListCalled = 0;

    repositoryWorker.fetchListStub = Future<List<Repository>>.value([dummyRepository(2)]);
    
    // when
    await sut.next();
    
    // then: worker
    expect(repositoryWorker.fetchListCalled, 1);

    // then: model
    expect(sut.items.length, 2);
  });
}