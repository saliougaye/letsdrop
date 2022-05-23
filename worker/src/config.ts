import dotenv from 'dotenv';

dotenv.config();

type Environment = 'DEV' | 'PROD';

interface Config {
    redisUrl: string
    databaseUrl: string,
    environment: Environment
}

const keyRequired : string[] = [
    "REDIS_URL",
    "DATABASE_URL"
]


keyRequired.forEach(el => {
    if(!process.env[el]) {
        throw new Error(`Missing Required env: ${el}`)
    }
});


const config : Config = {
    redisUrl: process.env.REDIS_URL!,
    databaseUrl: process.env.DATABASE_URL!,
    environment: process.env.NODE_ENV !== undefined && process.env.NODE_ENV === 'PROD' ? 'PROD' : 'DEV'
};

export default config;

