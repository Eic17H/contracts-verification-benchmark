methods {
    function getState() external returns (Escrow.State) envfree;
    function getBuyer() external returns (address) envfree;
    function getSeller() external returns (address) envfree;
    function getArbiter() external returns (address) envfree;
    function getBalance() external returns (uint) envfree;
    function getDeposit() external returns (uint) envfree;
    function getFee() external returns (uint) envfree;
}