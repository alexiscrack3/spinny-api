/* eslint-disable import/no-extraneous-dependencies */
const faker = require('faker');
const Club = require('../../app/models/club');

const clubs = [];
for (let index = 0; index < 50; index += 1) {
    const club = new Club({
        name: faker.random.words().toLowerCase(),
    });
    clubs.push(club);
}

module.exports = clubs;
