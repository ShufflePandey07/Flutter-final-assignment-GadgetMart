import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/favourites/domain/usecases/favourites_usecase.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:final_assignment/features/gadgets/domain/usecases/gadget_usecase.dart';
import 'package:final_assignment/features/gadgets/presentation/viewmodel/gadget_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'gadget_unit_test.mocks.dart';
import 'test_data/gadget_test_data.dart';

@GenerateNiceMocks([
  MockSpec<GadgetUseCase>(),
  MockSpec<CartUsecase>(),
])
void mainTest() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GadgetUseCase mockGadgetUseCase;
  late CartUsecase mockCartUsecase;
  late FavouritesUsecase mockFavouritesUsecase;

  late ProviderContainer container;
  late List<GadgetEntity> lstGadgets;

  setUp(() {
    mockGadgetUseCase = MockGadgetUseCase();
    mockCartUsecase = MockCartUsecase();
    mockFavouritesUsecase = MockFavouritesUsecase();
    lstGadgets = GadgetTestData.getGadgetTestData();
    container = ProviderContainer(
      overrides: [
        gadgetViewModelProvider.overrideWith(
          (ref) => GadgetViewModel(
            gadgetUseCase: mockGadgetUseCase,
            cartUsecase: mockCartUsecase,
            favouritesUsecase: mockFavouritesUsecase,
          ),
        ),
      ],
    );
  });

  group('fetchGadgets', () {
    test('emits loading state and then data on success', () async {
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Right(lstGadgets));

      await container.read(gadgetViewModelProvider.notifier).fetchGadgets();

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
      expect(gadgetState.gadgets, lstGadgets);
    });

    test('emits loading state and then error on failure', () async {
      const error = 'Error occurred';
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Left(Failure(error: error.toString())));

      await container.read(gadgetViewModelProvider.notifier).fetchGadgets();

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
      expect(gadgetState.error, error);
    });
  });

  group('addToCart', () {
    test('emits loading state and then success on add to cart success',
        () async {
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Right(lstGadgets));
      final cartEntity = CartEntity(
          gadgetEntity: lstGadgets[0] /* initialize cart entity */,
          quantity: 4,
          total: 120);
      when(mockCartUsecase.addToCart(
              CartEntity(gadgetEntity: lstGadgets[0], quantity: 4, total: 120)))
          .thenAnswer((_) async => const Right(true));

      await container
          .read(gadgetViewModelProvider.notifier)
          .addToCart(cartEntity);

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
    });

    test('emits loading state and then error on add to cart failure', () async {
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Right(lstGadgets));
      final cartEntity = CartEntity(
          gadgetEntity: lstGadgets[0] /* initialize cart entity */,
          quantity: 4,
          total: 0);
      const error = 'Add to cart failed';
      when(mockCartUsecase.addToCart(cartEntity))
          .thenAnswer((_) async => Left(Failure(error: error)));

      await container
          .read(gadgetViewModelProvider.notifier)
          .addToCart(cartEntity);

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
      expect(gadgetState.error, error);
    });

    tearDown(() {
      container.dispose();
    });
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GadgetUseCase mockGadgetUseCase;
  late CartUsecase mockCartUsecase;
  late FavouritesUsecase mockFavouritesUsecase;
  late ProviderContainer container;
  late List<GadgetEntity> lstGadgets;

  setUp(() {
    mockGadgetUseCase = MockGadgetUseCase();
    mockCartUsecase = MockCartUsecase();
    mockFavouritesUsecase = MockFavouritesUsecase();
    lstGadgets = GadgetTestData.getGadgetTestData();
    container = ProviderContainer(
      overrides: [
        gadgetViewModelProvider.overrideWith(
          (ref) => GadgetViewModel(
            gadgetUseCase: mockGadgetUseCase,
            cartUsecase: mockCartUsecase,
            favouritesUsecase: mockFavouritesUsecase,
          ),
        ),
      ],
    );
  });

  group('fetchGadgets', () {
    test('emits loading state and then data on success', () async {
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Right(lstGadgets));

      await container.read(gadgetViewModelProvider.notifier).fetchGadgets();

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
      expect(gadgetState.gadgets, lstGadgets);
    });

    test('emits loading state and then error on failure', () async {
      const error = 'Error occurred';
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Left(Failure(error: error.toString())));

      await container.read(gadgetViewModelProvider.notifier).fetchGadgets();

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
      expect(gadgetState.error, error);
    });
  });

  group('addToCart', () {
    test('emits loading state and then success on add to cart success',
        () async {
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Right(lstGadgets));
      final cartEntity = CartEntity(
          gadgetEntity: lstGadgets[0] /* initialize cart entity */,
          quantity: 4,
          total: 120);
      when(mockCartUsecase.addToCart(
              CartEntity(gadgetEntity: lstGadgets[0], quantity: 4, total: 120)))
          .thenAnswer((_) async => const Right(true));

      await container
          .read(gadgetViewModelProvider.notifier)
          .addToCart(cartEntity);

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
    });

    test('emits loading state and then error on add to cart failure', () async {
      when(mockGadgetUseCase.pagination(any, any))
          .thenAnswer((_) async => Right(lstGadgets));
      final cartEntity = CartEntity(
          gadgetEntity: lstGadgets[0] /* initialize cart entity */,
          quantity: 4,
          total: 0);
      const error = 'Add to cart failed';
      when(mockCartUsecase.addToCart(cartEntity))
          .thenAnswer((_) async => Left(Failure(error: error)));

      await container
          .read(gadgetViewModelProvider.notifier)
          .addToCart(cartEntity);

      final gadgetState = container.read(gadgetViewModelProvider);

      expect(gadgetState.isLoading, false);
      expect(gadgetState.error, error);
    });

    tearDown(() {
      container.dispose();
    });
  });
}
