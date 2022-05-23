import { instantiatePruneDropsWorker } from './workers/index';

(async () => {

    console.log('Worker Started');
    
    await instantiatePruneDropsWorker();


})()