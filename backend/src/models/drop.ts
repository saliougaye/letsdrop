import Artist from "./artist";
import Country from "./country";

interface Drop {
    _id: string,
    album: string,
    dropDate: Date,
    country: Country,
    artists: Artist[]
}

export default Drop;