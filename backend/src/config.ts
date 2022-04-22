import IConfig from "./interfaces/IConfig";


const envs = [
    "SPOTIFY_API_KEY"
];

envs.forEach(e => {
    if(process.env[e] === undefined) {
        throw new Error(`Missing required env: ${e}`)
    }
})


const config : IConfig = {
    spotifyApiKey: process.env.SPOTIFY_API_KEY!
}


export default config;