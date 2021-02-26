import { Router } from "express";
import fs from "fs";
import processPath from "../lib/path";

// Initialization
const router = Router();

router.get('/:path?', async(req, res, next)=>{
	/*
	Ejecuta en el navegador en archivo html que le envie
	res.sendFile(path.join(__dirname, '../views/html/index.html'));
	*/
	try{
		const dirPath = processPath(req.params.path);
    	const dir = await fs.promises.opendir(dirPath.absolutePath);
    	const content = { files: [], directories: [], all: []};

    	for await (const dirent of dir) {
      		if (dirent.isDirectory()) {
        		content.directories.push(dirent.name);
        		content.all.push(dirent.name);
      		} else {
        		content.files.push(dirent.name);
        		content.all.push(dirent.name);
      		}
    	}
    	content.files.sort()
    	content.directories.sort()
		content.all.sort()

    	res.json({ path: `${dirPath.relativePath}`, content, success: true });
	}catch (err){
		next(err);
	}
});

export default router;