import { IResolvers } from "mercurius";
import Country from "../models/country";
import countryService from "../services/countryService";

const resolvers : IResolvers = {
    Query: {
        countries: (_, args, ctx, info) : Promise<Country[]> => {
            return countryService.countries({
                name: args.name
            });
        }
    }
}

export default resolvers;