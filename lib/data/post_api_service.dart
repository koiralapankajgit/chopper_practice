import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart' as prefix0;

/// Inorder to make code generation possible we need to create part statement
part 'post_api_service.chopper.dart';

/// This file will store post api service which will extend chopper service
/// Choppers works by genereting code which is the reason we made this class abastract
/// Actual implementation of this class will be inside generated class
///
/// In order to make this class actually work with chopper we need to mark  it with an anotation  of [@ChopperApi()] which takse base url
/// [baseUrl] is api url
///

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  /// Function which get all posts from the api
  /// Only declaring function will not work we have to specify which http request we are sending. For that we will anotate function with request type.
  @Get()
  Future<Response> getPosts();

  /// This function will get single post from the api
  ///
  /// Id should be dynamically assignable so we have to place inside curly braces
  ///
  /// Decliring int parameter id doesnt assign value to path itself. We have to anotate by @Path() inorder ro receive and assign id to path url from the parameter
  ///
  /// Headers can be used in both [@Get()] anotation function as well as in dart function e.g [getPost()]. If header is of fixed nature use annotation function else use dart function.
  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);

  /// Implimentation of Put, Patch and Delete request is same as Post request
  /// Post request required body
  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  /// [ChopperClient] is build on top of the default dart [http] client.
  ///
  /// What we need to do inorder to use the [PostApiService] to simplify our work with the jsonplaceholder api is to some how connected together with [ChopperClient] by passing the chopper client over to the generated classes constructor.
  ///
  /// Basically we need  to instantiated the chopper client. The best place and most elignent way to do this is directly inside PostApiService , inside static function called create() which will return PostApiService which is already setup with the client to get a with the generated class and all of that good setup.
  ///
  /// [baseUrl] is top level domain of the api and this is the best place to write url insted in [@ChopperApi()]. Different endpoints are going to be entered in [@ChopperApi()] annotation.
  ///
  /// In [services] we are going to pass services which is the generated class. This is just to let the chopper client know which kind of services is  gonna work with.
  ///
  /// This way by calling the static function [create()]  will return a fully setup and initialized PostApiService instance.
  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: prefix0.JsonConverter(),
    );

    return _$PostApiService(client);
  }
}