interface ICountryResponse {
    name: ICountryName,
    ccn3: string,
    flag: string
}


interface ICountryName {
    common: string
}



export default ICountryResponse;