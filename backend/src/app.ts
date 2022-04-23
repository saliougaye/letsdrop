import dotenv from 'dotenv';
import fastify, { FastifyInstance } from "fastify";
import { Server, IncomingMessage, ServerResponse } from 'http';
import mercurius from 'mercurius';


import { schema, resolvers } from './graphql/index';


dotenv.config();

const app : FastifyInstance<Server, IncomingMessage, ServerResponse> = fastify({
    logger: false
});


app.register(mercurius, {
    schema: schema,
    resolvers: resolvers,
    graphiql: 'graphiql',
});


export default app;