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

    type Drop {
        id: ID!
        album: String!
        dropDate: String!
        country: Country!
        artists: [Artist!]!
    }

    input CountryInput {
        name: String
        code: String
        flag: String
    }

    input ArtistInput {
        id: String
        name: String
        image: String
        link: String
    }

    input DropInput {
        album: String
        dropDate: String
        country: CountryInput
        artists: [ArtistInput]
    }

    type Query {
        countries: [Country!]!
        artists(name: String!, token: String!): [Artist]!
        drops: [Drop!]!
    }

    type Mutation {
        createDrop(drop: DropInput!): Drop
        deleteDrop(id: ID!): Drop!
    }

`;

export default schema;