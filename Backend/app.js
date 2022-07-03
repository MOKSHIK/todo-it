require('dotenv').config()
const express = require('express')
const morgan = require('morgan')
const mongoose = require('mongoose')
const cors = require('cors')
const authJwt = require('./helpers/jwt')
const errorHandler = require('./helpers/errorHandler')
const app = express()

// constants
const port = process.env.PORT

// middleware
app.use(cors())
app.options('*', cors())
app.use(express.json())
app.use(morgan('tiny'))
app.use(authJwt())
app.use(errorHandler)

const authentication = require('./routes/authentication')
const todoHandler = require('./routes/todoHandler')
const userRoute = require('./routes/user')

app.use('/authentication', authentication)
app.use('/todolist', todoHandler)
app.use('/user', userRoute)

// server connection
app.listen(port || 5000, () => { console.log(`Server's live ${ port == undefined ? 5000 : port}`) })

// database connection
mongoose.connect(process.env.CONNECTION_STRING, () => {
    mongoose.connection.readyState == 1 ?
    console.log("Connected to mongoDB atlas.") : 
    console.log("Could not connect to mongoDB atlas.")
})