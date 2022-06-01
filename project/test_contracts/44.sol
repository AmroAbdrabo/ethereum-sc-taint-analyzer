pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe
contract Contract {
  address owner;
  address a;


  function baz() public {
    owner=msg.sender;
    a= address(0xDEADBEEF);
  }

  function foo() public {
    a=msg.sender;
    owner= address(0xDEADBEEF);  
  }

  function bar() public {
    require(a == msg.sender); // guard
    require(owner == msg.sender);
    selfdestruct(msg.sender); // safe
  }
}
