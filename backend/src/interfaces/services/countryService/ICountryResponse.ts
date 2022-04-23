interface ICountryResponse {
    name: ICountryName,
    ccn3: string,
    flags: ICountryFlags
}


interface ICountryName {
    common: string
}

interface ICountryFlags {
    png: string,
    svg: string
}


export default ICountryResponse;