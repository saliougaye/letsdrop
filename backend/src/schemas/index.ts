import {
    country
} from "./types/index"

import { 
    getCountries
} from "./query/index";
import { mergeTypeDefs } from "@graphql-tools/merge";


const schemas: string[] = [
    country,
    getCountries
];


export default schemas;