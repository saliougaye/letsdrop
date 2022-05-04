import axios from 'axios';
import { IGetArtistsProps, ISearchResponse } from '../interfaces/services/spotifyService';
import Artist from '../models/artist';
import { createArtist } from '../utils/factories';

const spotifyService = () => {

    const url = "https://api.spotify.com/v1";

    const getArtists = async (props: IGetArtistsProps) : Promise<Artist[]> => {

        const { data } = await axios.get<ISearchResponse>(`${url}/search?type=artist&q=${props.name}`, {
            headers: {
                Authorization: `Bearer ${props.token}`
            }
        });


        const artists = data.artists.items.map(el => createArtist(el));

        return artists;
    }


    return {
        getArtists
    }
}

export default spotifyService();