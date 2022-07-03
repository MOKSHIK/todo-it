const mongoose = require('mongoose');

const todoSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref : 'User',
        required: true,
    },
    task: {
        type: String,
        required: true,
    },
}, { versionKey: false });

exports.Todo = mongoose.model('Todo', todoSchema);