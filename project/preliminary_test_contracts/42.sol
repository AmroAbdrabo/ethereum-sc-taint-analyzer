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

  function foo(int i) public {
    if (i > 0) {
      require(msg.sender == safe_addr); // guard
      selfdestruct(msg.sender); // safe
    } else {
      if (unsafe_int > 0) {
        safe_addr = unsafe_addr;
      }
      selfdestruct(safe_addr); // vulnerable
    }
  }
}
