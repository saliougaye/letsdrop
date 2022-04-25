import mongoose from "mongoose";
import Artist from "../models/artist";
import Country from "../models/country";
import Drop from "../models/drop";

const Schema = mongoose.Schema;


const {
    String: MongoString,
    Date: MongoDate
} = Schema.Types;



const countrySchema = new Schema<Country>({
    code: {
        type: MongoString,
        required: true,
        trim: true
    },
    name: {
        type: MongoString,
        required: true,
        trim: true
    },
    flag: {
        type: MongoString,
        required: true,
        trim: true
    }
});

const artistSchema = new Schema<Artist>({
    id: {
        type: MongoString,
        required: true,
    },
    name: {
        type: MongoString,
        required: true,
    },
    image: {
        type: MongoString,
        required: false,
    },
    link: {
        type: MongoString,
        required: true,
    },
})

const dropSchema = new Schema<Drop>({
    album: {
        type: MongoString,
        required: true,
        trim: true
    },
    dropDate: {
        type: MongoDate,
        required: true,
    },
    country: {
        type: countrySchema,
        required: true
    },
    artists: {
        type: [artistSchema],
        required: true,
    }
});

const Drop = mongoose.model('Drop', dropSchema);

export default Drop;