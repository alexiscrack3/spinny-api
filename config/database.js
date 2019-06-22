const debug = require('debug')('spinny:server');

const environments = {
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
        config = environments.test;
        break;
    case 'production':
        config = environments.production;
        break;

    default:
        config = environments.development;
}

module.exports = config;
