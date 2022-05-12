import axios from "axios";
import { FastifyReply, FastifyRequest, HookHandlerDoneFunction } from "fastify";

const preHandler = async (req: FastifyRequest, reply: FastifyReply, done: HookHandlerDoneFunction) => {

    if(req.headers.authorization == null) {
        reply.code(401).send();
        done();
        return;
    }


    try {
        const res = await axios.get("https://api.spotify.com/v1/me", {
            headers: {
                'authorization': `Bearer ${req.headers.authorization}`
            }
        });    

        if(res.status == 401) {
            reply.code(401).send();
            done();
            return;
        }

    } catch (error) {
        reply.code(500).send();
        done();
        return;
    }
    


    done();
}

export default preHandler;