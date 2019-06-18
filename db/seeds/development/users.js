const User = require('../../../app/models/user');
const faker = require('faker');

var users = [
    new User({
        firstName: 'Alexis',
        lastName: 'Ortega',
        email: 'asdf@gmail.com',
        password: 'asdf'
    })
];
for (let index = 0; index < 10; index++) {
    const user = new User({
        firstName: faker.name.firstName(),
        lastName: faker.name.lastName(),
        email: faker.internet.email().toLowerCase(),
        password: 'asdf'
    });
    users.push(user);
}

module.exports = users;
