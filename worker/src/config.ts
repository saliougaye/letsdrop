import dotenv from 'dotenv';

dotenv.config();

type Environment = 'DEV' | 'PROD';

interface Config {
    redisHost: string,
    redisPort: number,
    databaseUrl: string,
    environment: Environment
}

const keyRequired : string[] = [
    "REDIS_HOST",
    "REDIS_PORT",
    "DATABASE_URL"
]


keyRequired.forEach(el => {
    if(!process.env[el]) {
        throw new Error(`Missing Required env: ${el}`)
    }
});


const config : Config = {
    redisHost: process.env.REDIS_HOST!,
    redisPort: parseInt(process.env.REDIS_PORT!),
    databaseUrl: process.env.DATABASE_URL!,
    environment: process.env.NODE_ENV !== undefined && process.env.NODE_ENV === 'PROD' ? 'PROD' : 'DEV'
};

export default config;

