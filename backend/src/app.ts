import dotenv from 'dotenv';
import fastify, { FastifyInstance } from "fastify";
import { Server, IncomingMessage, ServerResponse } from 'http';
import mercurius from 'mercurius';
import { preHandler } from './hooks/index';

import { schema, resolvers } from './graphql/index';


dotenv.config();

const app : FastifyInstance<Server, IncomingMessage, ServerResponse> = fastify({
    logger: true
});

app.addHook('preHandler', preHandler);

app.register(mercurius, {
    schema: schema,
    resolvers: resolvers,
    graphiql: process.env.NODE_ENV === 'DEBUG' ? 'graphiql' : undefined,
});


export default app;