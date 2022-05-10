pragma solidity ^0.5.0;

// the contract is vulnerable
// the output of your analyzer should be Tainted
contract Contract {
	address payable user;
	address payable owner;

	function registerUser() public {
		user = msg.sender;
	}

	function check(address x) public returns(address) { return foo1(x); }
	function foo1(address x) public returns(address) { return foo2(x); }
	function foo2(address x) public returns(address) { return foo3(x); }
	function foo3(address x) public returns(address) { return foo4(x); }
	function foo4(address x) public returns(address) { return foo5(x); }
	function foo5(address x) public returns(address) { return foo6(x); }
	function foo6(address x) public returns(address) { return foo7(x); }
	function foo7(address x) public returns(address) { return foo8(x); }
	function foo8(address x) public returns(address) { return foo9(x); }
	function foo9(address x) public returns(address) { return foo10(x); }
	function foo10(address x) public returns(address) { return x; }

	function main() public {
		if(msg.sender == check(owner)) { // guard
			selfdestruct(msg.sender);  // safe
		} 
	}

	function bar() public {
		if(msg.sender == check(user)) { // not a guard
			selfdestruct(msg.sender);  // vulnerable
		} 
	}

}
