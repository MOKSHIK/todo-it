const { User } = require('../models/userModel');
const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
var validator = require("email-validator");

// constants
const secret = process.env.SECRET
const salt = process.env.SALT

// register
router.post('/register', async (req,res) => {
    //Email not valid(true)
    if (!validator.validate(req.body.email)) {
        return res.status(400).send({
            message: "Enter a valid email ID",
            auth: false 
        })
    }
    let usedEmail = await User.findOne({email: req.body.email})
    if (usedEmail == undefined) {
        let user = User({
            username: req.body.name.toLowerCase(),
            email: req.body.email,
            password: bcrypt.hashSync(req.body.password, parseInt(salt)),
        })
        user = await user.save()
        if (!user) {
            return res
                .status(500)
                .send({
                    message: "The user could not be registered.",
                    success: false
                })
        } else {
            return res.
            status(200).
            send({
                message: "Successfully registered.",
                success: true
            })
        }

    }
    else {
        return res.status(400).send({
            message : "Email already exists.",
            success : false
        })
    }   
})

// login
router.post('/login' , async (req,res) => {
    let userExist = await User.findOne({email: req.body.email})
    if(userExist == undefined){
        return res.status(400).send({
            message: "ThIs email does not Exist",
            auth: false 
        })
    }
    else {
        if (bcrypt.compareSync(req.body.password, userExist.password)) {
            const token = jwt.sign({  
                userName : userExist.username 
                }, 
                secret,
                { 
                    expiresIn : '10d'
            })
            return res.status(200).send({
                id : userExist._id,
                token : token,
                message: `Welcome back, ${userExist.username}`,
                auth: true
            })
        }
        else {
            return res.status(400).send({
                message: "Incorrect password",
                auth: false
            })
        } 
    }
    
})
module.exports = router
