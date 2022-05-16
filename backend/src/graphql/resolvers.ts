import { IResolvers } from "mercurius";
import DropOutput from "../interfaces/dto/DropOutput";
import Country from "../models/country";
import countryService from "../services/countryService";
import dropsService from "../services/dropsService";

const resolvers : IResolvers = {
    Query: {
        countries: (_, args, ctx, info) : Promise<Country[]> => {
            return countryService.countries({});
        },
        drops: (_, args, ctx, info) : Promise<DropOutput[]> => {
            return dropsService.getDrops({
                user: args.user
            });
        },
    },
    Mutation: {
        createDrop: (_, args, ctx, info) : Promise<DropOutput> => {

            const { drop } = args

            return dropsService.insertDrop({
                drop: {
                    album: drop.album,
                    user: drop.user,
                    dropDate: drop.dropDate,
                    country: drop.country,
                    artists: drop.artists
                }
            });
        },
        deleteDrop: (_, args, ctx, info) : Promise<DropOutput> => {
            return dropsService.deleteDrop({
                id: args.id
            });
        },
    }
}

export default resolvers;