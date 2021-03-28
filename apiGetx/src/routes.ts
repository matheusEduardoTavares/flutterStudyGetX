import { Router, Request, Response } from 'express';

import users from './counter_object';

const routes = Router();

routes.get('/users', (request: Request, response: Response) => {
    const { page = 1, limit = 1 } = request.query

    const pageValue = Number(page.toString()) || 1;
    const limitValue = Number(limit.toString()) || 1;

    console.log('(pageValue * limitValue)', (pageValue * limitValue), 'users.length', users.length)

    if ((pageValue * limitValue) - limitValue >= users.length) {
        return response.json(
            []
        );
    }

    const usersMinorIndex = users.filter((_, index) => index < ((pageValue * limitValue) + 1));
    const usersPaginated = usersMinorIndex.slice((usersMinorIndex.length - 1 - limitValue), usersMinorIndex.length - 1);

    return response.json(
        usersPaginated
    );
});

export default routes;