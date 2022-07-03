function errorHandler(err, req, res, next) {
    if (err.name === "UnauthorizedError") {
        return res.
            status(500).
            send({
                message: "The user is not authorized.",
                success : false
            })// jwt authentication error
    }
    else if (err.name === "ValidationError") {
        return res.
            status(500).
            send({
                message: err,
                success : false
            })// validation error
    }
    else {
        return res.
            status(500).
            send({
                message: err,
                success : false
            })// default error
    }
}

module.exports = errorHandler