pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address safe_addr;
  address unsafe_addr;
  int safe_int;
  int unsafe_int;

  function set_unsafe_addr(address a) public {
    unsafe_addr = a;
  }

  function set_safe_int(int i) public {
    safe_int = i;
    require(msg.sender == safe_addr); // guard
  }

  function set_unsafe_int(int i) public {
    unsafe_int = i;
    require(msg.sender == unsafe_addr); // not a guard
  }

  function check() public returns(bool) {
    if (safe_int > 5) {
      return msg.sender == safe_addr;
    } else {
      return safe_addr == safe_addr;
    }
  }

  function foo() public {
    require(check()); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
