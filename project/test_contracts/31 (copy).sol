pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  int i;
  address a;
  address b;
  address c;

  function set_rec(address x) public {
    if (i <= 0) {
      a = x;
      b = x;
    } else {
      i = i - 1;
      set_rec(x);
    }
  }

  function foo() public {
    require(msg.sender == c); // guard
    selfdestruct(msg.sender); // safe
  }
}
