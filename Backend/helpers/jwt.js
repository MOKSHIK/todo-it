const { expressjwt: jwt } = require("express-jwt");

// constants
const secret = process.env.SECRET

function authJwt() {
    return jwt({
        secret: secret,
        algorithms: ['HS256'],
    }).unless({
        path: [
            '/authentication/login',
            '/authentication/register',
        ]
    })
}

module.exports = authJwt