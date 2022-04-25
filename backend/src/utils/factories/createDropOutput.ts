import moment from "moment";
import DropOutput from "../../interfaces/dto/DropOutput";
import Drop from "../../models/drop";

export const createDropOutput = (drop: Drop) : DropOutput => {
    return {
        id: drop._id,
        album: drop.album,
        artists: drop.artists,
        country: drop.country,
        dropDate: moment(drop.dropDate).format("yyyy-MM-dd")
    }
}