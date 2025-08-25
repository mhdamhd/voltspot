import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:voltspot/core/entities/base_entity.dart';
import 'package:voltspot/core/extensions/model_extensions/model_extensions.dart';
import 'package:voltspot/core/models/base_model.dart';
import 'package:voltspot/core/utils/app_response.dart';

import 'error_message_model.dart';
import 'exception.dart';
import 'failure.dart';

/// The method of type: [FutureFunction] expresses a waiting condition of type Generic
/// The method of type: [RequestFunction] expresses a waiting condition of type Dio [Response]
typedef FutureFunction<T> = Future<T> Function();
typedef RequestFunction<T> = Future<Response<T>> Function();

/// class [ErrorsHandler] defaine as Global Exception Handler,
/// [exceptionThrower] handles throw cases of exception according to the application's use cases,
/// [handleEither] handles possible errors and converting to either form.

class ErrorsHandler {
// this function to handle APIs exception this make you don't have to call any try catch in your code
  static Future<AppResponse> exceptionThrower(RequestFunction function) async {
    try {
      /// call Future function and return [AppResponse]
      final response = await function();
      final AppResponse appResponse = AppResponse.fromDioResponse(response);
      if (appResponse.statusCode != 200) {
        throw ServerException(ErrorMessageModel.fromJson(response));
      }
      return appResponse;
    } on DioException catch (e) {
      // if back end return an error response and its json format
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        throw ServerException(ErrorMessageModel.fromJson(e.response!));
      }

      // any anther throws to any anther exception types showld be here
      // ...

      // un known Exception
      if (e.response != null) {
        throw UnknownException(message: e.message);
      }

      // no internet Exception
      throw NoInternetException();
    } catch (e) {
      // in json parsion error
      if (e is TypeError) {
        throw ParsingException(parsingMessage: e.toString());
      }

      rethrow;
    }
  }

  // this function check possible exceptions and return either (left as Failure , right as Type you generic send)
  static Future<Either<Failure, T>>
      handleEither<T extends BaseEntity, M extends BaseModel>(
    FutureFunction<M> future,
  ) async {
    try {
      /// first call your [FutureFunction] function
      final result = await future();
      return Right(result.toEntity() as T);
    } catch (e) {
      /// then catch any errors + check types then return [Left] appropriate [Failure]

      return Left(failureThrower(e));
    }
  }

  static Future<Either<Failure, List<E>>>
  handleEitherList<E extends BaseEntity, M extends BaseModel<E>>(
      FutureFunction<List<M>> future,
      ) async {
    try {
      final list = await future();   // List<M>
      return Right(list.toEntityList()); // List<E>
    } catch (e) {
      return Left(failureThrower(e));
    }
  }

  static Failure failureThrower(Object e) {
    if (e is ServerException) {
      return ServerFailure(
        e.errorMessageModel.statusMessage,
        statusCode: e.errorMessageModel.statusCode,
      );
    }
    if (e is NoInternetException) {
      return NoInternetFailure();
    }
    if (e is UnknownException) {
      return UnknownFailure();
    }
    return Failure(e.toString());
  }
}
