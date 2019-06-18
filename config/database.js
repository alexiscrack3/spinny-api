const debug = require('debug')('spinny:server');

const configs = {
    test: {
        connection: 'mongodb://localhost:27017/spinny_test',
        seeds: {
            directory: '/seeds/test'
        }
    },
    development: {
        connection: 'mongodb://localhost:27017/spinny_development',
        seeds: {
            directory: '/seeds/development'
        }
    },
    production: {
        connection: 'mongodb://localhost:27017/spinny',
        seeds: {
            directory: '/seeds/development'
        }
    }
};

const env = process.env.NODE_ENV || 'development';
debug('Running on ' + env);

let config = null;
switch (env) {
    case 'test':
        config = configs.test;
        break;
    case 'production':
        config = configs.production;
        break;

    default:
        config = configs.development;
}

module.exports = config;
