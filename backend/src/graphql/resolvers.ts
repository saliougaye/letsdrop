import { IResolvers } from "mercurius";
import Artist from "../models/artist";
import Country from "../models/country";
import countryService from "../services/countryService";
import spotifyService from "../services/spotifyService";

const resolvers : IResolvers = {
    Query: {
        countries: (_, args, ctx, info) : Promise<Country[]> => {
            return countryService.countries({});
        },
        artists: (_, args, ctx, info) : Promise<Artist[]> => {
            return spotifyService.getArtists({
                name: args.name,
                token: args.token
            })
        }
    }
}

export default resolvers;