import 'package:letsdrop/constants/token.dart';
import 'package:letsdrop/models/country.dart';
import 'package:letsdrop/models/drop.dart';
import 'package:letsdrop/services/graphql_service.dart';

class ApiService {
  final GraphQlService _graphQlService =
      GraphQlService(AppTokens.Backend);

  ApiService();

  Future<Drop> createDrop(String token, Drop drop) async {
    const String query = """
      mutation CreateDrop(\$drop: DropInput!){
        createDrop(drop: \$drop) {
          id
          album
          dropDate
          country {
            name
            code
            flag
          }
          artists {
            id
            name
            link
          }
        }
      }

    """;

    final result = await _graphQlService
        .mutation(query, token, variables: {'drop': drop.toJson()});

    if (result.hasException) {
      throw Exception(result.exception);
    }

    if (result.data == null) {
      throw Exception("Drop not found");
    }

    final Object? rawDrop = result.data!['createDrop'];
    final Drop dropCreated = Drop.fromJson(rawDrop as Map<String, dynamic>);

    return dropCreated;
  }

  Future<Drop> deleteDrop(String token, String id) async {
    const String query = """
      mutation DeleteDrop(\$id: ID!){
        deleteDrop(id: \$id) {
          id
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

    final result = await _graphQlService.mutation(query, token, variables: {
      'id': id,
    });

    if (result.hasException) {
      throw Exception(result.exception);
    }

    if (result.data == null) {
      throw Exception("Drop not found");
    }

    final Object? rawDrop = result.data!['deleteDrop'];
    final Drop drop = Drop.fromJson(rawDrop as Map<String, dynamic>);

    return drop;
  }

  Future<List<Country>> getCountries(String token) async {
    const String query = """
      query {
        countries {
          name
          code
          flag
        }
      }
    """;
  
    final result = await _graphQlService.query(query, token);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    if (result.data == null) {
      return [];
    }

    final List<Object?> rawCountries = result.data!['countries'];
    final List<Country> countries =
        rawCountries.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();

    return countries;
  }

  Future<List<Drop>> getDrops(String token, String user) async {
    String query = """
      query {
        drops(user: "$user") {
          id
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

    final result = await _graphQlService.query(query, token);

    if (result.hasException) {
      throw Exception(result.exception);
    }

    if (result.data == null) {
      return [];
    }
    final List<Object?> rawDrops = result.data!['drops'];
    final List<Drop> drops =
        rawDrops.map((e) => Drop.fromJson(e as Map<String, dynamic>)).toList();

    return drops;
  }
}
