/// @custom:ghost
bool wasOwner_;
bool assigned_;

/// @custom:negate
/// @custom:invariant
function invariant(address a) public {
    if(assigned_) assert(wasOwner_ == (a == owner));
    else {
        wasOwner_ = (a == owner);
        assigned_ = true;
    }
}