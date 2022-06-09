pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
  address safe_addr;
  address unsafe_addr;
  int safe_int;
  int unsafe_int;
  bool x;
  bool y;

  function set_unsafe_addr(address a) public {
    unsafe_addr = a;
  }
function get_bool1() public returns(bool){
    bool s;
    s = (safe_addr == unsafe_addr);
    return s;
  }
  
  function get_bool2() public returns(bool){
    bool s;
    s = (safe_addr == msg.sender);
    return  s;
  }

  function set_unsafe_int(int i) public {
    unsafe_int = i;
    require(msg.sender == unsafe_addr); // not a guard
  }

  function check() public returns(bool) {
    //bool x; // TODO: test with x as a field also
    if (safe_int > 5) {
      x= (safe_int == safe_int);
    } else {
      if (unsafe_int < 3){
        x = get_bool2();
      }
    }
    y = x || get_bool2(); //  x safe again
    y = get_bool2();
    y = x || get_bool2();
    //y = (msg.sender == unsafe_addr);
    //y = (msg.sender == safe_addr);
    return y;
  }

  function foo() public {
    require(check()); // guard
    selfdestruct(msg.sender); // safe
  }
}
