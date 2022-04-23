import { gql } from "mercurius-codegen";

const schema = gql`
    type Country {
        name: String
        code: String
        flag: String
    }

    type Query {
        """ Method to get countries """
        countries(name: String!): [Country]
    }

`;

export default schema;