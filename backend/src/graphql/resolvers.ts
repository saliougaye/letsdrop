import { IResolvers } from "mercurius";
import DropOutput from "../interfaces/dto/DropOutput";
import Artist from "../models/artist";
import Country from "../models/country";
import Drop from "../models/drop";
import countryService from "../services/countryService";
import dropsService from "../services/dropsService";

const resolvers : IResolvers = {
    Query: {
        countries: (_, args, ctx, info) : Promise<Country[]> => {
            return countryService.countries({});
        },
        drops: (_, args, ctx, info) : Promise<DropOutput[]> => {
            return dropsService.getDrops();
        },
    },
    Mutation: {
        createDrop: (_, args, ctx, info) : Promise<DropOutput> => {

            const { drop } = args

            return dropsService.insertDrop({
                drop: {
                    album: drop.album,
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