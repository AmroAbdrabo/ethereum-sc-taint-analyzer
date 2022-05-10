pragma solidity ^0.5.0;

// the contract is safe
// the output of your analyzer should be Safe

// a, b, and c are initialized to be safe
// therefore, the three require statements are guards, making x trusted
// a, b, and c then remain trusted
contract Contract {
  address payable a;
  address payable b;
  address payable c;

  function set_a(address payable x) public {
    a = x;
    require(msg.sender == b); // guard
  }

  function set_b(address payable x) public {
    b = x;
    require(msg.sender == c); // guard
  }

  function set_c(address payable x) public {
    c = x;
    require(msg.sender == a); // guard
  }

  function destruct_a() public {
    selfdestruct(a); // safe
  }

  function destruct_b() public {
    selfdestruct(b); // safe
  }

  function destruct_c() public {
    selfdestruct(c); // safe
  }
}
