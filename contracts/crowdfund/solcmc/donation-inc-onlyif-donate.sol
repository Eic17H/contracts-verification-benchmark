function donation_inc_onlyif_donate(uint f, address user) public payable {
    
    uint donation_prev = donation[user];

    if(f==1)
        donate();
    else if(f==2)
        withdraw();
    else if(f==3)
        reclaim();
    else
        require(false);

    uint donation_next = donation[user];

    assert ( donation_next <= donation_prev || f==1 && user == msg.sender);
}