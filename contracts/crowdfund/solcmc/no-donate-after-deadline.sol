// calls to `donate` will revert if the donation phase has ended.

function invariant() public payable {
    require(block.number > end_donate);

    donate();

    assert(false);
}