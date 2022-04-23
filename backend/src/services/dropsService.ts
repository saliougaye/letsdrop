import { IDeleteDropProps } from '../interfaces/services/dropService'
import ICreateDropProps from '../interfaces/services/dropService/ICreateDropProps';
import DropModel from '../schema/drop';
import Drop from '../models/drop';
import IGetDropProps from '../interfaces/services/dropService/IGetDropProps';

const dropsService = () => {

    const getDrops = async () : Promise<Drop[]> => {
        const drops = await DropModel.find({});

        return drops;
    }


    const deleteDrop = async (props: IDeleteDropProps) : Promise<Drop> => {
        const dropDeleted = await DropModel.findOneAndDelete({
            _id: props.id
        });

        if(!dropDeleted) {
            throw new Error("Not found")
        }

        return dropDeleted;
    }

    const getDrop = async (props: IGetDropProps) : Promise<Drop> => {
        const drop = await DropModel.findById(props.id);

        
        if(!drop) {
            throw new Error("Not found")
        }

        return drop;
    }

    const insertDrop = async (props: ICreateDropProps) : Promise<Drop> => {
        const dropCreated = await DropModel.create(props.drop);

        if(!dropCreated) {
            throw new Error("drop not created");
        }

        return dropCreated;
    }

    return {
        getDrops,
        getDrop,
        insertDrop,
        deleteDrop
    }
}


export default dropsService();