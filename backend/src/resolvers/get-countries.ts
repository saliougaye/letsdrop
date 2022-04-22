import { IResolvers } from "mercurius";
import Country from "../models/country";

const resolver : IResolvers = {
    Query: {
        countries: async () : Promise<Country[]> => {
            return [
                {
                    name: "test",
                    code: "code",
                    flag: "flag"
                }
            ]
        }
    }
}

export default resolver;