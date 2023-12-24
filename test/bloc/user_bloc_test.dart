
// import 'package:chatters/Models/user.dart';
// import 'package:chatters/bloc/user_bloc/user_bloc.dart';
// import 'package:chatters/bloc/user_bloc/user_event.dart';
// import 'package:chatters/bloc/user_bloc/user_states.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'user_repo_moc.dart';
// import 'package:bloc_test/bloc_test.dart';

// void main() {
//   group('Search repo bloc', () {
//     late UserBloc mocBLoc;
//     late MockUserRepo mocRepo;

//     setUpAll(() {
//       mocRepo = MockUserRepo();
//       mocBLoc = UserBloc(userRepository: mocRepo);
//     });

//   blocTest('emit [UserLoading, UserLoaded]', 
//   build: () => mocBLoc,
//   act: (bloc) => bloc.add(const FetchUser()),
//   expect: (() => [
//     UserLoading(),
//     UserLoaded(user: [Cuser()])
//   ])
//   ); 
// });
// }
