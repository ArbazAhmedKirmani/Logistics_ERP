class AuthenticationService {

    constructor(){
        this.repository = new UserRepository()
    }
}

module.exports = AuthenticationService