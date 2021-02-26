import manageErr from "./base";

const enoent = (err, req, res, next) => {
    manageErr(err, {
    code: 'ENOENT',
    message: 'File or directory does not exist',
    statusCode: 400,
  });
  next(err);
};

export default enoent;