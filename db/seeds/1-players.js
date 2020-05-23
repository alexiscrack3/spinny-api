/* eslint-disable import/no-extraneous-dependencies */
const faker = require('faker');
const Player = require('../../app/models/player');

const password = 'asdf';
const players = [
    new Player({
        // firstName: 'Alexis',
        // lastName: 'Ortega',
        email: 'asdf@gmail.com',
        password,
    }),
];
for (let index = 0; index < 10; index += 1) {
    const player = new Player({
        // firstName: faker.name.firstName(),
        // lastName: faker.name.lastName(),
        email: faker.internet.email().toLowerCase(),
        password,
    });
    players.push(player);
}

module.exports = players;
