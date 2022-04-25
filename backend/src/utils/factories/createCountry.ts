import Country from "../../models/country";
import { ICountryResponse } from '../../interfaces/services/countryService/index';

export const createCountry = (countryResponse: ICountryResponse) : Country => {
    return {
        name: countryResponse.name.common,
        code: countryResponse.ccn3,
        abbreviation: countryResponse.cca2.toLowerCase()
    }
}