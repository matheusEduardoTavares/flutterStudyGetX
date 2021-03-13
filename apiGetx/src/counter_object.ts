const users = new Array(100);

let counter = 1;

for(let index = 0; index < 100; index++){
    users[index] = {
        'name': `name${counter}`,
        'id': `id${counter}`,
        'username': `username${counter}`,
    };
    counter++;
}

export default users;