import path from "path";
import storage from "../storage";

const slash = process.platform === 'win32' ? '\\' : '/';

const processPath = (urlPath) => {
  const relativePath = urlPath ? urlPath.replace(/--/g, slash) : slash;
  const absolutePath = path.join(storage, relativePath);

  return { relativePath, absolutePath };
};

export default processPath;