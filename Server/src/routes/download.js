const express = require('express');
const mime = require('mime-types');
const processPath = require('../lib/path');

// Initialization
const router = express.Router();

router.get('/:path/download', (req, res, err) => {
  try {
    const file = processPath(req.params.path).absolutePath;
    const mimetype = mime.lookup(file);
    console.log(mimetype);
    res.setHeader('Content-Disposition', `attachment; filename=${file}`);
    res.setHeader('Content-Type', mimetype);
    res.download(file);
  } catch (err) {
    next(err);
  }
});

module.exports = router;