import Artist from "./artist";
import Country from "./country";

interface Drop {
    id?: string,
    album: string,
    dropDate: Date,
    country: Country,
    artists: Artist[]
}

export default Drop;