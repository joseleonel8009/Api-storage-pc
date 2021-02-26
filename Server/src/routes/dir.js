import { Router } from "express";
import fs from "fs";
import path from "path";
import processPath from "../lib/path";

// Initialization
const router = Router();

router.post('/dirCreate/:path?/:name', async (req, res, next) => {
  const dirPath = processPath(req.params.path);
  // req.body.name
  const name = req.params.name;
  if (!name) {
    return res.status(400).json({
      success: false,
      message: 'No name was specified',
    });
  }

  try {
    await fs.promises.mkdir(path.join(dirPath.absolutePath, name));
  } catch (e) {
    return next(e);
  }

  res.json({ success: true, message: `Carpeta Creada con nombre ${name}` });
});

router.post('/dirRemove/:path?/:name', async (req, res, next) => {
  const dirPath = processPath(req.params.path);
  const name = req.params.name;
  if(!name){
    return res.status(400).json({
      success: false,
      message: 'No name was specified',
    });
  }

  try {
    await fs.promises.rmdir(path.join(dirPath.absolutePath, name));
  } catch (e) {
    return next(e);
  }

  res.json({ success: true, message: `Carpeta Eliminada con nombre ${name}` });
});

export default router;