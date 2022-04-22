import dotenv from 'dotenv';
import fastify, { FastifyInstance } from "fastify";
import mercurius from 'mercurius';
import {makeExecutableSchema} from '@graphql-tools/schema';
import schemas from './schemas/index';
import resolvers from './resolvers';
import { mergeResolvers, mergeTypeDefs } from '@graphql-tools/merge';
import { Server, IncomingMessage, ServerResponse } from 'http'
dotenv.config();

const app : FastifyInstance<Server, IncomingMessage, ServerResponse> = fastify({
    logger: true
});

const schema = makeExecutableSchema<any>({
    typeDefs: mergeTypeDefs(schemas),
    resolvers: mergeResolvers(resolvers),
});

app.register(mercurius, {
    schema: schema,
    graphiql: 'graphiql',
});

app.listen(3000, '0.0.0.0', (err, address) => {
    if(err) {
        console.log(err);
        process.exit(1);
    }

    console.log(`Server listening at ${address}`);
    
})
