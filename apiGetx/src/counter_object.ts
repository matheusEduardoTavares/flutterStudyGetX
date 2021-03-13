const usersLength = 1000;

const users = new Array(usersLength);

let counter = 1;

for(let index = 0; index < usersLength; index++){
    users[index] = {
        'name': `name${counter}`,
        'id': `id${counter}`,
        'username': `username${counter}`,
    };
    counter++;
}

export default users;