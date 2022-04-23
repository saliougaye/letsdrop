import { gql } from "mercurius-codegen";

const schema = gql`
    type Country {
        name: String
        code: String
        flag: String
    }

    type Artist {
        id: String
        name: String
        image: String
        link: String
    }

    type Query {
        """ Method to get countries """
        countries: [Country]
        artists(name: String!, token: String!): [Artist]
    }

`;

export default schema;