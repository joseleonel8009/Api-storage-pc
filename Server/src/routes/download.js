import { Router } from "express";
import mime from "mime-types";
import processPath from "../lib/path";

// Initialization
const router = Router();

router.get('/download/:path?/:name', (req, res, next) => {

  const { path, name } = req.params;
  const filePath = processPath(path + "/" + name).absolutePath;
  const download = `${filePath}`;

  if (!path) {
    return res.json({
      success: false,
      message: 'No path was specified'
    });
  }

  try {
    const mimetype = mime.lookup(filePath);
    res.setHeader('Content-Disposition', `attachment; filename=${name}`);
    res.setHeader('Content-Type', mimetype);
    res.download(download);
  } catch (err) {
    next(err);
  }
});

export default router;