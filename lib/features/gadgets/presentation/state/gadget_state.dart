import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';

class GadgetState {
  final bool isLoading;
  final String error;
  final List<GadgetEntity> gadgets;
  final bool hasReachedMax;
  final int page;

  factory GadgetState.initial() {
    return GadgetState(
        isLoading: false,
        error: '',
        gadgets: [],
        hasReachedMax: false,
        page: 0);
  }

  GadgetState(
      {required this.isLoading,
      required this.error,
      required this.gadgets,
      required this.hasReachedMax,
      required this.page});

  GadgetState copyWith({
    bool? isLoading,
    String? error,
    List<GadgetEntity>? gadgets,
    bool? hasReachedMax,
    int? page,
  }) {
    return GadgetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      gadgets: gadgets ?? this.gadgets,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }
}
