import 'package:letsdrop/models/artist.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/services/graphql_service.dart';

abstract class IApiService {

  Future<List<Drop>> getDrops();

  Future<List<Country>> getCountries();

  Future<List<Artist>> getArtists(String name, String token);

  Future<Drop> createDrop(Drop drop);

  Future<Drop> deleteDrop(String id);

}

class ApiService extends IApiService {
  final GraphQlService _graphQlService = GraphQlService("http://10.0.2.2:3000/graphql");

  ApiService();

  @override
  Future<Drop> createDrop(Drop drop) async {
    
    const String query = """
      mutation {
        createDrop(drop: \$drop) {
          _id
          album
          dropDate
          country {
            name
            code
            flag
          }
          artists {
            name
            link
          }
        }
      }
    """;

    final result = await _graphQlService.mutation(query, variables: {
      'drop': drop.toJson()
    });

    if(result.hasException) {
      throw Exception(result.exception);
    }

    if(result.data == null) {
      throw Exception("Drop not found");
    }

    final Map<String, dynamic> rawDrop = result.data!['deleteDrop'];
    final Drop dropCreated = Drop.fromJson(rawDrop);

    return dropCreated;
  }

  @override
  Future<Drop> deleteDrop(String id) async {
    const String query = """
      mutation {
        deleteDrop(id: \$id) {
          _id
          album
          dropDate
          country {
            name
            code
            flag
          }
          artists {
            name
            link
          }
        }
      }
    """;

    final result = await _graphQlService.mutation(query, variables: {
      'id': id,
    });

    if(result.hasException) {
      throw Exception(result.exception);
    }

    if(result.data == null) {
      throw Exception("Drop not found");
    }

    final Map<String, dynamic> rawDrop = result.data!['deleteDrop'];
    final Drop drop = Drop.fromJson(rawDrop);

    return drop;
  }

  @override
  Future<List<Artist>> getArtists(String name, String token) async {
    
    const String query = """
      query {
        artists(
          token: \$token
          name: \$name
        ) {
          id
          name
          image
          link
        }
      }
    """;

    final result = await _graphQlService.query(query, variables: {
      'token': token,
      'name': name
    });

    if(result.hasException) {
      throw Exception(result.exception);
    }

    if(result.data == null) {
      return [];
    }

    final List<Map<String, dynamic>> rawArtists = result.data!['artists'];
    final List<Artist> artists = rawArtists.map((e) => Artist.fromJson(e)).toList();

    return artists;
  }

  @override
  Future<List<Country>> getCountries() async {
    
    const String query = """
      query {
        countries {
          name
          code
          flag
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

    final List<Map<String, dynamic>> rawCountries = result.data!['countries'];
    final List<Country> countries = rawCountries.map((e) => Country.fromJson(e)).toList();

    return countries;
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