const express = require('express');
const fs = require('fs');
const path = require('path');
const processPath = require('../lib/path');

// Initialization
const router = express.Router();

router.post('/dir/:path?/:name', async (req, res, next) => {
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

module.exports = router;