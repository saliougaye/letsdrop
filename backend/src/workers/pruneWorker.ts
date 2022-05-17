import Queue from "bull";
import dropsService from "../services/dropsService";
import config from "../utils/config";

const pruneQueueName = 'prune-drops-queue'

const pruneQueue = new Queue<any>(pruneQueueName, config.redis);

pruneQueue.process(async (_, done) => {

    try {
        await dropsService.pruneDrops();

        console.log("👍 drops pruned successfully");


    } catch (error: any) {
        
        console.log(`❌ drops pruned worker error: ${error}`)
    }

    
    done();
    
});


const instantiatePruneWorker = () => {


    pruneQueue.add({}, {
        repeat: {
            cron: '0 0 * * *',

        }
    });

    console.log("✅ Instantiated Worker")

}





export default instantiatePruneWorker;