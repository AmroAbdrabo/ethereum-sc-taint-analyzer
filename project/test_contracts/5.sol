pragma solidity ^0.5.0;

contract Contract {
  address payable owner;
  function func1() public {
    if(msg.sender == owner)      // guard
      selfdestruct(msg.sender);  // safe
    else                         // guard
      selfdestruct(msg.sender);  // safe
  }
  function func2() public {
    if(msg.sender == owner) {}   // guard
    else {}                      // guard
    selfdestruct(msg.sender);    // safe
  }
  function func3() public {
    if(msg.sender == owner) {}   // guard
    selfdestruct(msg.sender);    // safe
  }
  function func4(uint x) public {
    if(x < 5) {                  // not a guard
      selfdestruct(msg.sender);  // vulnerable
    } else {
      require(msg.sender == address(0xDEADBEEF)); // guard
      selfdestruct(msg.sender);                   // safe
    }
  }
}
