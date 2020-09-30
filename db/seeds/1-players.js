/* eslint-disable import/no-extraneous-dependencies */
const faker = require('faker');
const Player = require('../../app/models/player');

const password = 'asdf';
const players = [
    new Player({
        first_name: 'Admin',
        last_name: 'Istrator',
        email: 'admin.istrator@mailinator.com',
        password,
    }),
];
for (let index = 0; index < 10; index += 1) {
    const player = new Player({
        first_name: faker.name.firstName(),
        last_name: faker.name.lastName(),
        email: `${faker.internet.userName().toLowerCase()}@mailinator.com`,
        password,
    });
    players.push(player);
}

module.exports = players;
