import { gql } from "mercurius-codegen";


const getCountries = gql`
    type Query {
        """ Method to get countries """
        countries(): [Countries]
    }
`;

export default getCountries;