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

  function foo(int i) public {
    int x = safe_int;
    x = unsafe_int + 2 - x;
    require(msg.sender == safe_addr || x < 10); // not a guard
    selfdestruct(msg.sender); // vulnerable
  }
}
