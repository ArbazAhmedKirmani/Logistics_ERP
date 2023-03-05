const express = require("express");
const expressApp = require("./src/express-app");
const { PORT } = require("./src/utils/config");

const startServer = () => {
  const app = express();
  expressApp(app);
  
  app.listen(PORT, () => {
    console.log(`$ server is connected to Port: ${PORT}`);
  });
};

startServer();
