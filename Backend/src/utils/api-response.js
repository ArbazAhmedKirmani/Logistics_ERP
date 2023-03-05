exports.ApiError = (msg, err) => ({
  error: true,
  message: msg,
  data: err,
});
