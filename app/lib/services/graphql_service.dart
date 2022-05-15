import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlService {

  final String url;

  GraphQlService._({ required this.url }) ;

  factory GraphQlService(String url) {

    return GraphQlService._(url: url);
  }

  //FIXME why double request (double request create two drops);

  Future<QueryResult> query(
      String query, String token, { Map<String, dynamic>? variables }) async {
    QueryOptions options = QueryOptions(
      document: gql(query), 
      variables: variables ?? {}, 
      fetchPolicy: FetchPolicy.networkOnly);

    final client = GraphQLClient(
      link: HttpLink(
        url, 
        defaultHeaders: {
          "authorization": token
        },
      ), 
      cache: GraphQLCache(),
    );

    final result = await client.query(options);

    

    return result;
  }

  Future<QueryResult> mutation(
      String query, String token, { Map<String, dynamic>? variables }) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables ?? {});

      
    final client = GraphQLClient(
      link: HttpLink(
        url, 
        defaultHeaders: {
          "authorization": token
      }), 
      cache: GraphQLCache()
    );


    final result = await client
          .mutate(options)
          .timeout(const Duration(seconds: 20));

    return result;
  }
}
