import Artist from "../../models/artist";
import Country from "../../models/country";

interface DropInput {
    album: string,
    dropDate: string,
    country: Country,
    artists: Artist[]
}

export default DropInput;