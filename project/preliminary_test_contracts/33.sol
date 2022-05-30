pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  int unsafe_int;
  address a;
  address b;
  address c;

  function set_unsafe_int(int i) public {
    unsafe_int = i;
  }

  function set_rec(int i, address x) public {
    if (i >= 5) {
      a = x;
    } else if (i <= -5 && unsafe_int > 1) {
      require(msg.sender == c);
      b = x;
    } else {
      set_rec(i+1, x);
    }
  }

  function foo() public {
    require(msg.sender == b); // not a guard due to implicit dependency of b on either i (if the execution goes through the if branch at line 16) or unsafe_int (if the execution goes through the else if branch at line 18).
    selfdestruct(msg.sender); // vulnerable
  }
}
