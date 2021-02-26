const err = (err, req, res, next) => {
    console.log(err);
    res.status(err.statusCode || 500).json({
      message: err.message,
      success: false
    });
  };
  
export default err;