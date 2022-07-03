const { Todo } = require('../models/todoModel');
const express = require('express');
const router = express.Router();

// Get User TODO'S
router.get('/list/:id', async (req,res) => {
    let list = await Todo.find({user: req.params.id})
    return res.status(200).send({
        data: list
    })
})

// ADD User TODO'S
router.post('/list/add', async (req,res) => {
    let todo = Todo({
        user: req.body.userID,
        task: req.body.task
    })
    todo = await todo.save()
    return res.status(200).send({
        message : "Succesfully Added",
        data : todo
    })
})

router.delete('/list/delete', async (req,res) => {
    await Todo.findByIdAndDelete(req.body.todoID)
    return res.status(200).send({
        message: "Todo Completed"
    }) 
})

module.exports = router