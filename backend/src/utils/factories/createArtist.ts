import { IArtistResponse, IArtistItemsResponse } from '../../interfaces/services/spotifyService/index'
import Artist from '../../models/artist'

export const createArtist = (artist: IArtistItemsResponse) : Artist => {
    return {
        id: artist.id,
        name: artist.name,
        link: artist.external_urls.spotify,
        image: artist.images[0].url   
    }
}