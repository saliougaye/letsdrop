import { gql } from "mercurius-codegen";

const country = gql`
    type Country {
        name: String
        code: String
        flag: String
    }
`;

export default country;