import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlService {
  final GraphQLClient _client;

  GraphQlService._(GraphQLClient client) : _client = client;

  factory GraphQlService(String url) {
    HttpLink link = HttpLink(url);

    GraphQLClient client = GraphQLClient(
      link: link, 
      cache: GraphQLCache()
    );

    return GraphQlService._(client);
  }

  Future<QueryResult> query(
      String query, { Map<String, dynamic>? variables }) async {
    QueryOptions options = QueryOptions(
      document: gql(query), 
      variables: variables ?? {}, 
      fetchPolicy: FetchPolicy.networkOnly);

    final result = await _client.query(options);

    return result;
  }

  Future<QueryResult> mutation(
      String query, { Map<String, dynamic>? variables }) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables ?? {});

    final result = await _client.mutate(options).timeout(const Duration(seconds: 5));

    return result;
  }
}
