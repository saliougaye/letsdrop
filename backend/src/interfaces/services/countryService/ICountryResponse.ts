interface ICountryResponse {
    name: ICountryName,
    ccn3: string,
    cca2: string
}


interface ICountryName {
    common: string
}



export default ICountryResponse;