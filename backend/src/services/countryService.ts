import axios from "axios"
import { ICountriesProps, ICountryResponse } from "../interfaces/services/countryService/index";
import Country from "../models/country"
import { createCountry } from '../utils/factories/index';

const countryService = () => {

    const url = "https://restcountries.com/v3.1";

    const countries = async (props: ICountriesProps) : Promise<Country[]> => {

        const { data } = await axios.get<ICountryResponse[]>(`${url}/all`);  // TODO cache

        const countries = data.map(el => createCountry(el));

        return countries;
    }

    return {
        countries
    }
}


export default countryService();