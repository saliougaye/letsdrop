import { Job, Queue, Worker, QueueScheduler } from 'bullmq';
import config from '../config';
import DropService from '../services/dropService';
import Logger from '../services/logger';

const PRUNE_QUEUE_NAME = 'prune-drops-queue';
const PRUNE_WORKER_NAME = 'prune-drops-worker';



const instantiatePruneDropsWorker = async () => {

    const logger = Logger(PRUNE_WORKER_NAME);

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

    const workerFunction = async (job: Job<any, any, string>) : Promise<any> => {

        const deletedCount = await DropService.pruneDrops();
    
        logger.info(`✅ Deleted ${deletedCount} drops`);
        
    }
    
    const workerOnCompleted = (job: Job<any, any, string>) => {
        logger.info(`✅ ${PRUNE_QUEUE_NAME} Job has completed successfully`, {
            jobId: job.id
        });
    }
    
    const workerOnFailed = (job: Job<any, any, string>, err: Error) => {
        logger.error(`❌ ${PRUNE_WORKER_NAME} failed`,err, {
            jobId: job.id
        })
        
    }

    const pruneDropsWorker = new Worker(PRUNE_QUEUE_NAME, workerFunction, {
        connection: {
            host: config.redisHost,
            port: config.redisPort
        }
    });

    pruneDropsWorker.on('completed', workerOnCompleted);
    pruneDropsWorker.on('failed', workerOnFailed);

    await pruneDropsQueue.add('prune-drops', { test: 'yes' }, {
        repeat: {
            cron: '0 0 * * *',
        }
    });
    

    logger.info(`✅ ${PRUNE_WORKER_NAME} instantiated`);
}





export {
    instantiatePruneDropsWorker
}