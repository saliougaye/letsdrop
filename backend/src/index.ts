import dotenv from 'dotenv';
import fastify, { FastifyInstance } from "fastify";
import { Server, IncomingMessage, ServerResponse } from 'http';
import mercurius from 'mercurius';


import { schema, resolvers } from './graphql/index';


dotenv.config();

const app : FastifyInstance<Server, IncomingMessage, ServerResponse> = fastify({
    logger: true
});

app.register(mercurius, {
    schema: schema,
    resolvers: resolvers,
    graphiql: 'graphiql',
});

app.listen(3000, '0.0.0.0', (err, address) => {
    if(err) {
        console.log(err);
        process.exit(1);
    }

    console.log(`Server listening at ${address}`);
    
})
