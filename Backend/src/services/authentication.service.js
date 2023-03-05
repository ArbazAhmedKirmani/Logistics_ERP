const UserRepository = require("../database/repositories/UserRepository");

class AuthenticationService {
  constructor() {
    this.repository = new UserRepository();
  }

  signup(username, employeeId) {
    try {
      //  await generatePassword()
      const result = this.repository.getUserByUsername({
        username,
        employeeId,
      });
    } catch (err) {
      throw new ApiError("Something went Wrong", err);
    }
  }
}

module.exports = AuthenticationService;
