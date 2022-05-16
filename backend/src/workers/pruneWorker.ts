import Queue from "bull";
import dropsService from "../services/dropsService";

const pruneQueueName = 'prune-drops-queue'

const pruneQueue = new Queue<any>(pruneQueueName);

pruneQueue.process(async (_, done) => {
    console.log('Deleting old drops');

    try {
        await dropsService.pruneDrops();

        done();

    } catch (error: any) {
        done(error)
    }

    
});


const instantiatePruneWorker = () => {


    pruneQueue.add({}, {
        repeat: {
            cron: '0 0 * * *'
        }
    });

    console.log("✅ Instantiated Worker")

}

pruneQueue.on('completed', (job, result) => {
    console.log("👍 drops pruned successfully");
});

pruneQueue.on('failed', (job, error) => {
    console.log(`❌ drops pruned worker error: ${error}`);
});




export default instantiatePruneWorker;