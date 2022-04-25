import Artist from "../../models/artist";
import Country from "../../models/country";

interface DropOutput {
    id: string,
    album: string,
    dropDate: String,
    country: Country,
    artists: Artist[]
}

export default DropOutput;