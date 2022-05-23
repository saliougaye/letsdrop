import { instantiatePruneDropsWorker } from './workers/index';
import throng from 'throng'

const workers = process.env.WEB_CONCURRENCY || 1;

const start = async () => {

    console.log('🚀 Worker Started');
    
    await instantiatePruneDropsWorker();
}


throng({
    workers: workers,
    worker: start,
    lifetime: Infinity
})