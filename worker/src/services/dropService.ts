import config from "../config";
import { MongoClient } from 'mongodb';
import moment from 'moment';

const DropService = () => {

    const client = new MongoClient(config.databaseUrl);

    const pruneDrops = async () : Promise<number> => {

        await client.connect();

        try {
            const db = client.db();

            const collection = db.collection('drops');

            const weekAgoDate = moment().subtract(7, 'days');

            const { deletedCount } = await collection.deleteMany({
                dropDate: {
                    $lte: weekAgoDate.toDate()
                }
            });
            
            return deletedCount;
            

        } catch (error) {

            throw new Error(`Failed to prune drops: ${error}`)
            
        } finally {

            await client.close();

        }

    }


    return {
        pruneDrops
    }
}

export default DropService();