// after the donation phase,
// if the contract balance decreases
// then either a successful `withdraw` or `reclaim` have been performed.

function invariant(
    uint choice
    //, address payable _newOwner // v3
    //, uint amount // v5
    //, address payable user // v11
) public payable {
    
    require(block.number > end_donate);

    uint _balance = address(this).balance;

    if (choice == 0) {
        donate();
    } else if (choice == 1) {
        withdraw();
        // withdraw(user); // v11
    } else if (choice == 2) {
        reclaim();
    }

    /* // v3
    else if (choice == 3) {
        setOwner(_newOwner);
    }//*/

    /* // v5
    else if (choice == 3) {
        require(msg.sender == owner); 
        setGoal(amount);
    }//*/

    /* // v11
    else if (choice == 3) {
        clawback();
    }//*/
    
    else {
        require(false);
    }
    
    require(address(this).balance < _balance);
    assert(choice == 1 || choice == 2);
}