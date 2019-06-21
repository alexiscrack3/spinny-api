const Player = require('../../../app/models/player');
const faker = require('faker');

var players = [
    new Player({
        // firstName: 'Alexis',
        // lastName: 'Ortega',
        email: 'asdf@gmail.com',
        password: 'asdf'
    })
];
for (let index = 0; index < 10; index++) {
    const player = new Player({
        firstName: faker.name.firstName(),
        lastName: faker.name.lastName(),
        email: faker.internet.email().toLowerCase(),
        password: 'asdf'
    });
    players.push(player);
}

module.exports = players;
