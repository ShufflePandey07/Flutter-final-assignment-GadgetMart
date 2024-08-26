// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/favorite_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:final_assignment/core/failure/failure.dart' as _i6;
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart'
    as _i7;
import 'package:final_assignment/features/favourites/domain/repository/i_favourites_repository.dart'
    as _i2;
import 'package:final_assignment/features/favourites/domain/usecases/favourites_usecase.dart'
    as _i4;
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

class _FakeIFavouritesRepository_0 extends _i1.SmartFake
    implements _i2.IFavouritesRepository {
  _FakeIFavouritesRepository_0(
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

/// A class which mocks [FavouritesUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavouritesUsecase extends _i1.Mock implements _i4.FavouritesUsecase {
  @override
  _i2.IFavouritesRepository get favouritesRepository => (super.noSuchMethod(
        Invocation.getter(#favouritesRepository),
        returnValue: _FakeIFavouritesRepository_0(
          this,
          Invocation.getter(#favouritesRepository),
        ),
        returnValueForMissingStub: _FakeIFavouritesRepository_0(
          this,
          Invocation.getter(#favouritesRepository),
        ),
      ) as _i2.IFavouritesRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> addToFavourites(
          _i7.FavouritesEntity? favouritesEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToFavourites,
          [favouritesEntity],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #addToFavourites,
            [favouritesEntity],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #addToFavourites,
            [favouritesEntity],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.FavouritesEntity>>>
      getFavourites() => (super.noSuchMethod(
            Invocation.method(
              #getFavourites,
              [],
            ),
            returnValue: _i5.Future<
                    _i3.Either<_i6.Failure, List<_i7.FavouritesEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.FavouritesEntity>>(
              this,
              Invocation.method(
                #getFavourites,
                [],
              ),
            )),
            returnValueForMissingStub: _i5.Future<
                    _i3.Either<_i6.Failure, List<_i7.FavouritesEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.FavouritesEntity>>(
              this,
              Invocation.method(
                #getFavourites,
                [],
              ),
            )),
          ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.FavouritesEntity>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> removeFromFavourites(
          String? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromFavourites,
          [productId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #removeFromFavourites,
            [productId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #removeFromFavourites,
            [productId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);
}
