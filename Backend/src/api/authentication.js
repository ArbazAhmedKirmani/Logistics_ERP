const { NText } = require("mssql");

module.exports = (app) => {
  //   const service = new AuthenticationService();

  app.post("/auth/signup", async (req, res, next) => {
    try {
      const { username, employeeCode } = req.body;
      res.send("Hello World");
    } catch (error) {
      next(error);
    }
  });
};
