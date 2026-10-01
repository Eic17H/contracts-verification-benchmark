function getState() public view returns (Escrow.State) {
    return state;
}

function getBuyer() public view returns (address) {
    return buyer;
}

function getSeller() public view returns (address) {
    return seller;
}

function getArbiter() public view returns (address) {
    return arbiter;
}

function getBalance() public view returns (uint) {
    return address(this).balance;
}

function getDeposit() public view returns (uint) {
    return deposit;
}

function getFee() public view returns (uint) {
    return fee;
}