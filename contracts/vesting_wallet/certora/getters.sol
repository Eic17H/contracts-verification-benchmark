function getBalance() public view returns (uint) {
    return address(this).balance;
}

function getStart() public view returns (uint64) {
    return start;
}

function getDuration() public view returns (uint64) {
    return duration;
}