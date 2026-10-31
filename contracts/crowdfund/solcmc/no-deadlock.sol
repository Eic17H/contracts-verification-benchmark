// at least one of the main functions (donate, withdraw, reclaim)
// must not revert if the contract has a balance and the caller has made a donation.

function invariant() public view {
    
    require(address(this).balance > 0);
    
    require(donation[address(this)] > 0);

    bool donateSuccess;
    bool withdrawSuccess;
    bool reclaimSuccess;

    try this.donate{value: 0}() {
        donateSuccess = true;
    } catch {
        donateSuccess = false;
    }

    try this.withdraw() {
        withdrawSuccess = true;
    } catch {
        withdrawSuccess = false;
    }

    try this.reclaim() {
        reclaimSuccess = true;
    } catch {
        reclaimSuccess = false;
    }

    assert(donateSuccess || withdrawSuccess || reclaimSuccess);
}
