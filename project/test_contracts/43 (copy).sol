pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address payable safe_addr;
  address payable unsafe_addr;
  int safe_int;
  int unsafe_int;

  function set_unsafe_addr(address payable a) public {
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

  function foo(int i, address payable x) public {
    if (i > 0) {
      require(msg.sender == safe_addr); // guard
      safe_addr = x;
    } else {
      if (unsafe_int > 0) {
        unsafe_addr = safe_addr;
      }
      selfdestruct(unsafe_addr); // vulnerable
    }
  }
}
