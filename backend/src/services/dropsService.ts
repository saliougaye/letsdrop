import { IDeleteDropProps } from '../interfaces/services/dropService'
import ICreateDropProps from '../interfaces/services/dropService/ICreateDropProps';
import IGetDropProps from '../interfaces/services/dropService/IGetDropProps';
import dropsRepository from '../repositories/dropsRepository';
import DropOutput from '../interfaces/dto/DropOutput';
import { createDropOutput } from '../utils/factories/createDropOutput';
import IGetDropsProps from '../interfaces/services/dropService/IGetDropsProps';
import moment from 'moment';


const dropsService = () => {

    const getDrops = async (props: IGetDropsProps) : Promise<DropOutput[]> => {
        const drops = await dropsRepository.getDrops(props.user);

        const dropsOutput = drops.map(el => createDropOutput(el));

        return dropsOutput;
    }


    const deleteDrop = async (props: IDeleteDropProps) : Promise<DropOutput> => {
        const dropDeleted = await dropsRepository.deleteDrop(props.id);

        if(!dropDeleted) {
            throw new Error("Not found")
        }

        return createDropOutput(dropDeleted);
    }

    const getDrop = async (props: IGetDropProps) : Promise<DropOutput> => {
        const drop = await dropsRepository.getDrop(props.id);

        
        if(!drop) {
            throw new Error("Not found")
        }

        return createDropOutput(drop);
    }

    const insertDrop = async (props: ICreateDropProps) : Promise<DropOutput> => {
        const dropCreated = await dropsRepository.insertDrop(props.drop);

        if(!dropCreated) {
            throw new Error("drop not created");
        }

        return createDropOutput(dropCreated);
    }

    const pruneDrops = async () : Promise<void> => {

        const weekAgoDate = moment().subtract(7, 'days');

        await dropsRepository.pruneDrops(weekAgoDate.toDate());

    }

    return {
        getDrops,
        getDrop,
        insertDrop,
        deleteDrop,
        pruneDrops
    }
}


export default dropsService();