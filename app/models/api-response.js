class APIResponse {
    constructor(data = null, errors = []) {
        this.data = data;
        this.errors = errors;
    }
}

module.exports = APIResponse;
