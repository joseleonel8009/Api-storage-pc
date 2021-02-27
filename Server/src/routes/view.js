import { Router } from "express";
import processPath from "../lib/path";
// import path from "path";
// import fs from "fs";

// Initialization
const router = Router();

router.get('/file/:path?/:name', async(req, res, next) => {
    const {path, name} = req.params;
    const pathProcesado = processPath(path + "/" + name).absolutePath;

    try {
        res.sendFile(pathProcesado);
    } catch (err) {
        next(err);
    }
    // res.json({
    //     success: true,
    //     url: `http://192.168.1.3:3000/file/${path}/${name}`
    // })
});

export default router;