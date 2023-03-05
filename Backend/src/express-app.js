const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const expressFileupload = require("express-fileupload");
const { authentication } = require("./api");

module.exports = async (app) => {
  // Global Variables
  global.__basedir = __dirname;

  // Express Setup
  app.use(express.json({ limit: "50mb" }));
  app.use(express.static(__dirname + "/public"));
  app.use(express.urlencoded({ extended: true, limit: "5mb" }));

  // Express File-Upload
  app.use(expressFileupload());

  // Cors Setup
  app.use(cors({ origin: "*" }));

  // General
  app.use(bodyParser.json());

  // api's | routes
  authentication(app);

  // error handling
  // app.use(HandleErrors);
};
