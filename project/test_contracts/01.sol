pragma solidity ^0.5.0;

contract Contract {
  address owner;
  function foo(int x) public {
    // guard
    if (x > 1){
        foo(x-1);
    }
    selfdestruct(msg.sender);      // safe
  }
  
}
