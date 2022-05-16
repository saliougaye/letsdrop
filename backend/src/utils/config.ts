import IConfig from "../interfaces/IConfig";

const envs = [
    "DATABASE_URL"
];

envs.forEach(el => {
    if(!process.env[el]) {
        throw new Error(`Missing Required env: ${el}`)
    }
})

const config : IConfig = {
    databaseUrl: process.env.DATABASE_URL!,
}

export default config;