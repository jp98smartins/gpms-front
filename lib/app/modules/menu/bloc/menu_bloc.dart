import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_events.dart';
part 'menu_states.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  // Usecase Here!

  MenuBloc() : super(MenuInitial());

  // Stream of ProductsLoaded State
  // Stream<MenuState> _eitherProductsLoadedOrErrorState(
  //     Either<Failure, List<Product>> failureOrListOfProduct) async* {
  //   yield failureOrListOfProduct.fold(
  //       (failure) => HomeError(failure: failure),
  //       // If return is a List<Product>, send ProductsLoaded State
  //       (productList) => productList != null
  //           ? ProductsLoaded(productList: productList)
  //           : HomeError(failure: ServerFailure()));
  // }

  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    switch (event.runtimeType) {
      case TestEvent:
        yield MenuLoaded();
        break;
      default:
        yield MenuInitial();
        break;
    }
  }
}
