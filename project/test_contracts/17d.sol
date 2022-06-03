pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address safe_addr;
  address unsafe_addr;
  int safe_int;
  int unsafe_int;
  bool x;

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
    //  TODO: test with x as a field also
    if (safe_int > 5) {
      x= (safe_int == safe_int);
    } else {
      if (unsafe_int > 3){
        x= (safe_addr == safe_addr);
      }else{
        x = (unsafe_addr == unsafe_addr);
      }
    }
    x = (safe_addr == msg.sender);
    return x;
  }

  function foo() public {
    require(check()); // guard
    selfdestruct(msg.sender); // safe
  }
}
