import 'package:final_assignment/core/common/common_widget/show_my_snackbar.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/favourites/domain/usecases/favourites_usecase.dart';
import 'package:final_assignment/features/gadgets/domain/usecases/gadget_usecase.dart';
import 'package:final_assignment/features/gadgets/presentation/state/gadget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gadgetViewModelProvider =
    StateNotifierProvider<GadgetViewModel, GadgetState>(
  (ref) => GadgetViewModel(
    gadgetUseCase: ref.read(gadgetUseCaseProvider),
    cartUsecase: ref.read(cartUsecaseProvider),
    favouritesUsecase: ref.read(favouritesUsecaseProvider),
  ),
);

class GadgetViewModel extends StateNotifier<GadgetState> {
  GadgetViewModel({
    required this.gadgetUseCase,
    required this.cartUsecase,
    required this.favouritesUsecase,
  }) : super(GadgetState.initial()) {
    fetchGadgets();
  }

  final GadgetUseCase gadgetUseCase;
  final CartUsecase cartUsecase;
  final FavouritesUsecase favouritesUsecase;

  resetState() async {
    state = GadgetState.initial();
    await fetchGadgets();
  }

  Future fetchGadgets() async {
    final currentState = state;
    state = state.copyWith(isLoading: true);
    final page = currentState.page + 1;
    final gadgets = currentState.gadgets;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      final result = await gadgetUseCase.pagination(page, 2);
      result.fold(
        (failure) => state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        ),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              gadgets: [...gadgets, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    } else {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: 'No more data', color: Colors.red);
    }
  }

  Future<void> addToCart(CartEntity cartEntity) async {
    state = state.copyWith(isLoading: true);
    final result = await cartUsecase.addToCart(cartEntity);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (data) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> addToFavourites(FavouritesEntity favouriteEntity) async {
    final result = await favouritesUsecase.addToFavourites(favouriteEntity);
    result.fold(
      (failure) => showMySnackBar(message: failure.error, color: Colors.red),
      (data) =>
          showMySnackBar(message: 'Added to favourites', color: Colors.green),
    );
  }

  Future<void> removeFromFavourites(String id) async {
    final result = await favouritesUsecase.removeFromFavourites(id);
    result.fold(
      (failure) => showMySnackBar(message: failure.error, color: Colors.red),
      (data) => showMySnackBar(
          message: 'Removed from favourites', color: Colors.green),
    );
  }
}
