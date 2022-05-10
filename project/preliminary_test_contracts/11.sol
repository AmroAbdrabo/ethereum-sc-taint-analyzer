pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
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
    int x = i * unsafe_int / 4;
    x = safe_int * 8;
    require(msg.sender == safe_addr || x < 10); // guard
    selfdestruct(msg.sender); // safe
  }
}
