import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/services/graphql_service.dart';

abstract class IApiService {

  Future<List<Drop>> getDrops();

  Future<List<Country>> getCountries();

  Future<List<Artist>> getArtists(String name);

  Future<Drop> createDrop(Drop drop);

  Future<Drop> deleteDrop(Drop drop);

}

class ApiService extends IApiService {
  final GraphQlService _graphQlService = GraphQlService("http://10.0.2.2:3000/graphql");

  ApiService();

  @override
  Future<Drop> createDrop(Drop drop) {
    // TODO: implement createDrop
    throw UnimplementedError();
  }

  @override
  Future<Drop> deleteDrop(Drop drop) {
    // TODO: implement deleteDrop
    throw UnimplementedError();
  }

  @override
  Future<List<Artist>> getArtists(String name) {
    // TODO: implement getArtists
    throw UnimplementedError();
  }

  @override
  Future<List<Country>> getCountries() {
    // TODO: implement getCountries
    throw UnimplementedError();
  }

  @override
  Future<List<Drop>> getDrops() async {

    const String query = """
      query {
        drops {
          _id
          album
          dropDate
          country {
            code
            name
            flag
          }
          artists {
            id
            name
            image
            link
          }
        }
      }
    """;

    final result = await _graphQlService.query(query);

    if(result.hasException) {
      throw Exception(result.exception);
    }

    if(result.data == null) {
      return [];
    }
    final List<Map<String, dynamic>> rawDrops = result.data!['drops'];
    final List<Drop> drops = rawDrops.map((e) => Drop.fromJson(e)).toList(); 

    return drops;
  }

  
}