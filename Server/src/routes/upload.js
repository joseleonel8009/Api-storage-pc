import { Router } from "express";
import expFileUp from "express-fileupload";
import processPath from "../lib/path";
import moveFile from "../lib/mv";
import fs from "fs";
import path from "path";

// Initialization
const router = Router();
router.use(expFileUp());

router.post('/upload/:path?', async(req, res, next) =>{
	if (!req.files) {
    	return res.status(400).json({
      		success: false,
      		message: 'No files were uploaded'
    	});
  	}

  	const dirPath = processPath(req.params.path);
  	let files = req.files.file;
  	if (!Array.isArray(files)) {
    	files = [files];
  	}

  	try {
    	for (const file of files) {
      		await moveFile(file, dirPath.absolutePath);
    	}
  	} catch (err) {
    	// Sys error
    	if (err.code) {
      		return next(err);
    	}

    	return res.status(400).json({
      		success: false,
      		message: err.message,
      		path: dirPath.relativePath
    	});
  	}

  res.json({
    success: true,
    message: 'Files successfully uploaded',
    path: dirPath.relativePath
  });
});

router.post('/delete/:pathU?/:name', async (req, res, next)=>{

	const { pathU, name } = req.params;

	const dirPath = processPath(pathU);

	if (!name) {
		return res.json({
			success: false,
			message: 'No name was specified'
		});
	}

	try {
		/*Para eliminar el archivo necesita tener la extencion de este*/
		await fs.promises.unlink(path.join(dirPath.absolutePath, name));
	} catch (e) {
		return next(e);
	}
	return res.json({
		success: true,
		message: 'File successfully delete'
	});
});

export default router;