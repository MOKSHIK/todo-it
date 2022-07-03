const { User } = require('../models/userModel');
const express = require('express');
const router = express.Router();

router.get('/:id', async (req,res) => {
    let user = await User.findById(req.params.id)
    return res.status(200).send({
        name : user.username
    })
})

module.exports = router