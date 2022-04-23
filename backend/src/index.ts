import mongoose from 'mongoose';
import app from './app';
import config from './utils/config';

mongoose.connect(config.databaseUrl, {}).then(() => {
    console.log("Connected to MongoDB");

    app.listen(3000, '0.0.0.0', (err, address) => {
        if (err) {
            console.log(err);
            process.exit(1);
        }

        console.log(`Server listening at ${address}`);

    });

});

const exitHandler = () => {
    app.close(() => {
        console.log('Server closed');
        process.exit(1);
    });
};

const unexpectedErrorHandler = (error: any) => {
    console.error(error);
    exitHandler();
};

process.on('uncaughtException', unexpectedErrorHandler);
process.on('unhandledRejection', unexpectedErrorHandler);

process.on('SIGTERM', () => {
    console.log('SIGTERM received');
    app.close()
});


