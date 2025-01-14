// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/gadget_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i3;
import 'package:final_assignment/core/failure/failure.dart' as _i8;
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart'
    as _i11;
import 'package:final_assignment/features/cart/domain/repository/i_cart_repository.dart'
    as _i4;
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart'
    as _i10;
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart'
    as _i13;
import 'package:final_assignment/features/favourites/domain/repository/i_favourites_repository.dart'
    as _i5;
import 'package:final_assignment/features/favourites/domain/usecases/favourites_usecase.dart'
    as _i12;
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart'
    as _i9;
import 'package:final_assignment/features/gadgets/domain/repository/i_gadget_repository.dart'
    as _i2;
import 'package:final_assignment/features/gadgets/domain/usecases/gadget_usecase.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIGadgetRepository_0 extends _i1.SmartFake
    implements _i2.IGadgetRepository {
  _FakeIGadgetRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeICartRepository_2 extends _i1.SmartFake
    implements _i4.ICartRepository {
  _FakeICartRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIFavouritesRepository_3 extends _i1.SmartFake
    implements _i5.IFavouritesRepository {
  _FakeIFavouritesRepository_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GadgetUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGadgetUseCase extends _i1.Mock implements _i6.GadgetUseCase {
  @override
  _i2.IGadgetRepository get gadgetRepository => (super.noSuchMethod(
        Invocation.getter(#gadgetRepository),
        returnValue: _FakeIGadgetRepository_0(
          this,
          Invocation.getter(#gadgetRepository),
        ),
        returnValueForMissingStub: _FakeIGadgetRepository_0(
          this,
          Invocation.getter(#gadgetRepository),
        ),
      ) as _i2.IGadgetRepository);

  @override
  _i7.Future<_i3.Either<_i8.Failure, List<_i9.GadgetEntity>>> pagination(
    int? page,
    int? limit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #pagination,
          [
            page,
            limit,
          ],
        ),
        returnValue:
            _i7.Future<_i3.Either<_i8.Failure, List<_i9.GadgetEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i9.GadgetEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, List<_i9.GadgetEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i9.GadgetEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
            ],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, List<_i9.GadgetEntity>>>);
}

/// A class which mocks [CartUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCartUsecase extends _i1.Mock implements _i10.CartUsecase {
  @override
  _i4.ICartRepository get cartRepository => (super.noSuchMethod(
        Invocation.getter(#cartRepository),
        returnValue: _FakeICartRepository_2(
          this,
          Invocation.getter(#cartRepository),
        ),
        returnValueForMissingStub: _FakeICartRepository_2(
          this,
          Invocation.getter(#cartRepository),
        ),
      ) as _i4.ICartRepository);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> addToCart(
          _i11.CartEntity? cartEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToCart,
          [cartEntity],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #addToCart,
            [cartEntity],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #addToCart,
            [cartEntity],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);

  @override
  _i7.Future<_i3.Either<_i8.Failure, List<_i11.CartEntity>>> getCart() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCart,
          [],
        ),
        returnValue:
            _i7.Future<_i3.Either<_i8.Failure, List<_i11.CartEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i11.CartEntity>>(
          this,
          Invocation.method(
            #getCart,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, List<_i11.CartEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i11.CartEntity>>(
          this,
          Invocation.method(
            #getCart,
            [],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, List<_i11.CartEntity>>>);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> removeFromCart(String? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromCart,
          [productId],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #removeFromCart,
            [productId],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #removeFromCart,
            [productId],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> updateQuantity(
    String? productId,
    int? quantity,
    double? price,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateQuantity,
          [
            productId,
            quantity,
            price,
          ],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #updateQuantity,
            [
              productId,
              quantity,
              price,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #updateQuantity,
            [
              productId,
              quantity,
              price,
            ],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> clearCart() => (super.noSuchMethod(
        Invocation.method(
          #clearCart,
          [],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #clearCart,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #clearCart,
            [],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> changeStatus() =>
      (super.noSuchMethod(
        Invocation.method(
          #changeStatus,
          [],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #changeStatus,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #changeStatus,
            [],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);
}

/// A class which mocks [FavouritesUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavouritesUsecase extends _i1.Mock implements _i12.FavouritesUsecase {
  @override
  _i5.IFavouritesRepository get favouritesRepository => (super.noSuchMethod(
        Invocation.getter(#favouritesRepository),
        returnValue: _FakeIFavouritesRepository_3(
          this,
          Invocation.getter(#favouritesRepository),
        ),
        returnValueForMissingStub: _FakeIFavouritesRepository_3(
          this,
          Invocation.getter(#favouritesRepository),
        ),
      ) as _i5.IFavouritesRepository);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> addToFavourites(
          _i13.FavouritesEntity? favouritesEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToFavourites,
          [favouritesEntity],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #addToFavourites,
            [favouritesEntity],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #addToFavourites,
            [favouritesEntity],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);

  @override
  _i7.Future<
      _i3.Either<_i8.Failure,
          List<_i13.FavouritesEntity>>> getFavourites() => (super.noSuchMethod(
        Invocation.method(
          #getFavourites,
          [],
        ),
        returnValue: _i7
            .Future<_i3.Either<_i8.Failure, List<_i13.FavouritesEntity>>>.value(
            _FakeEither_1<_i8.Failure, List<_i13.FavouritesEntity>>(
          this,
          Invocation.method(
            #getFavourites,
            [],
          ),
        )),
        returnValueForMissingStub: _i7
            .Future<_i3.Either<_i8.Failure, List<_i13.FavouritesEntity>>>.value(
            _FakeEither_1<_i8.Failure, List<_i13.FavouritesEntity>>(
          this,
          Invocation.method(
            #getFavourites,
            [],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, List<_i13.FavouritesEntity>>>);

  @override
  _i7.Future<_i3.Either<_i8.Failure, bool>> removeFromFavourites(
          String? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromFavourites,
          [productId],
        ),
        returnValue: _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
            _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #removeFromFavourites,
            [productId],
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i3.Either<_i8.Failure, bool>>.value(
                _FakeEither_1<_i8.Failure, bool>(
          this,
          Invocation.method(
            #removeFromFavourites,
            [productId],
          ),
        )),
      ) as _i7.Future<_i3.Either<_i8.Failure, bool>>);
}
