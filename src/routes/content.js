const express = require('express');
const fs = require('fs');
const path = require('path');
const processPath = require('../lib/path');

// Initialization
const router = express.Router();

router.get('/:path?', async(req, res, next)=>{
	/*
	Ejecuta en el navegador en archivo html que le envie
	res.sendFile(path.join(__dirname, '../views/html/index.html'));
	*/
	try{
		const dirPath = processPath(req.params.path);
    	const dir = await fs.promises.opendir(dirPath.absolutePath);
    	const content = { files: [], directories: [] };

    	for await (const dirent of dir) {
      		if (dirent.isDirectory()) {
        		content.directories.push(dirent.name);
      		} else {
        		content.files.push(dirent.name);
      		}
    	}
    	content.directories.sort()
    	content.files.sort()

    	res.json({ path: `${dirPath.relativePath}`, content, success: true });
	}catch (err){
		next(err);
	}
});

module.exports = router