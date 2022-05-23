import { Job, Queue, Worker, QueueScheduler } from 'bullmq';
import config from '../config';
import DropService from '../services/dropService';

const PRUNE_QUEUE_NAME = 'prune-drops-queue';
const PRUNE_WORKER_NAME = 'prune-drops-worker';



const instantiatePruneDropsWorker = async () => {

    const pruneDropsQueueScheduler = new QueueScheduler(PRUNE_QUEUE_NAME, {
        connection: {
            host: config.redisHost,
            port: config.redisPort
        }
    });

    const pruneDropsQueue = new Queue(PRUNE_QUEUE_NAME, {
        connection: {
            host: config.redisHost,
            port: config.redisPort
        }
    });

    const pruneDropsWorker = new Worker(PRUNE_QUEUE_NAME, workerFunction, {
        connection: {
            host: config.redisHost,
            port: config.redisPort
        }
    });

    pruneDropsWorker.on('completed', workerOnCompleted);
    pruneDropsWorker.on('failed', workerOnFailed);
//     pruneDropsWorker.on('progress', workerOnProgress)

    await pruneDropsQueue.add('prune-drops', { test: 'yes' }, {
        repeat: {
            cron: '* * * * *',
        }
    });

    console.log(`✅ ${PRUNE_WORKER_NAME} instantiated`);
}


const workerFunction = async (job: Job<any, any, string>) : Promise<any> => {

    const deletedCount = await DropService.pruneDrops();

    console.log(`✅ Deleted ${deletedCount} drops`)
    
}

const workerOnCompleted = (job: Job<any, any, string>) => {
    // FIXME log to file
    console.log(`✅ ${PRUNE_QUEUE_NAME} Job has completed successfully -> JobId: ${job.id}`);
}

const workerOnFailed = (job: Job<any, any, string>, err: Error) => {
    // FIXME log to file
    console.log(`❌ ${PRUNE_QUEUE_NAME} has failed with ${err.message}\nJob Id: ${job.id}\n${err}`);
}

// const workerOnProgress = () => {

// }


export {
    instantiatePruneDropsWorker
}