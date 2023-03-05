const bcrypt = require("bcrypt");
const saltRounds = 10;

class Password {
  constructor() {}

  /**
   * this method generate Hash Password from plain text
   * @param {String} password Plain Text Password
   */
  async generate(password) {
    new Promise((resolve, reject) => {
      bcrypt.hash(password, saltRounds, function (err, hash) {
        if (!err) {
          resolve(hash);
        }
        reject(err);
      });
    });
  }
}

module.exports = Password;
