import DropModel from '../schema/drop';
import Drop from '../models/drop';
import DropInput from '../interfaces/dto/DropInput';

const dropsRepository = () => {

    const getDrops = async (user: string) : Promise<Drop[]> => {
        const drops = await DropModel.find({
            user: {
                $eq: user
            }
        });

        return drops;
    }


    const deleteDrop = async (id: string) : Promise<Drop> => {
        const dropDeleted = await DropModel.findOneAndDelete({
            _id: id
        });

        if(!dropDeleted) {
            throw new Error("Not found")
        }

        return dropDeleted;
    }

    const getDrop = async (id: string) : Promise<Drop> => {
        const drop = await DropModel.findById(id);

        
        if(!drop) {
            throw new Error("Not found")
        }

        return drop;
    }

    const insertDrop = async (drop: DropInput) : Promise<Drop> => {
        const dropCreated = await DropModel.create(drop);

        if(!dropCreated) {
            throw new Error("drop not created");
        }

        return dropCreated;
    }

    const pruneDrops = async (date: Date) : Promise<void> => {
        
        await DropModel.deleteMany({
            dropDate: {
                $lte: date
            }
        });
        
    }

    return {
        getDrops,
        getDrop,
        insertDrop,
        deleteDrop,
        pruneDrops
    }
}


export default dropsRepository();