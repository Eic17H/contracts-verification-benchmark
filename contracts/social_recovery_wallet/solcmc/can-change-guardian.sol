/// @custom:ghost
bool wasGuardian_;
bool assigned_;

/// @custom:negate
/// @custom:invariant
function invariant(address a) public {
    if(assigned_) assert(wasGuardian_ == isGuardian(a));
    else {
        wasGuardian_ = isGuardian(a);
        assigned_ = true;
    }
}