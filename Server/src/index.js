import express from "express";
import morgan from'morgan';

import content from "./routes/content";
import upload from "./routes/upload";
import dir from "./routes/dir";
import download from "./routes/download";

import enoent from'./middlewares/enoent';
import eexist from'./middlewares/eexist';
import err from'./middlewares/err';

// Initializations
const app = express();

// Settings
const port = process.env.PORT || 3000;

// Middlewares
// app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Routes
app.use(content);
app.use(upload);
app.use(dir);
app.use(download);

// Errors
app.use(enoent);
app.use(eexist);
app.use(err);

// Server on Port
app.listen(port, ()=>{
    console.log('Server on port: ',port)
});