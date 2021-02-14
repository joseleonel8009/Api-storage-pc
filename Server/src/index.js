const express = require('express');
const morgan = require('morgan');
const path = require('path');

const enoent = require('./middlewares/enoent');
const eexist = require('./middlewares/eexist');
const err = require('./middlewares/err');

// Initializations
const app = express();

// Settings
const port = process.env.PORT || 3000;

// Middlewares
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Routes
app.use(require('./routes/content'));
app.use(require('./routes/upload'));
app.use(require('./routes/createDir'));
app.use(require('./routes/download'));

// Errors
app.use(enoent);
app.use(eexist);
app.use(err);

// Server on Port
app.listen(port, ()=>{
    console.log('Server on port: ', port)
});