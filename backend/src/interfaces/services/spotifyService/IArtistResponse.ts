export interface ISearchResponse {
    artists: IArtistResponse
}

export interface IArtistResponse {
    items: IArtistItemsResponse[]
}

export interface IArtistItemsResponse {
    id: string,
    name: string,
    images: IArtistImageResponse[],
    external_urls: IArtistExternalUrls
}

export interface IArtistImageResponse {
    height: number,
    url: string,
    width: number
}

export interface IArtistExternalUrls {
    spotify: string
}