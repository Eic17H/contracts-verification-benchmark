// the contract balance does not increase after the end of the donation phase.

function no_receive_after_deadline(uint f, address a) public payable {
    require(block.number > end_donate);

    uint balBefore = address(this).balance;

    if(f==1)
        donate();
    else if(f==2)
        withdraw();
    else if(f==3)
        reclaim();
    else
        assert(false);
    
    uint balAfter = address(this).balance;

    assert(balBefore >= balAfter);
}