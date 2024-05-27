// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.6.0;
//v0.1.0
import "./Ownable.sol";
import "./SafeMath.sol";
import "./ERC20.sol";
import "./TokenSpender.sol";
contract RLC is ERC20, SafeMath, Ownable {

    /* Public variables of the token */
  string public name;       //fancy name
  string public symbol;
  uint8 public decimals;    //How many decimals to show.
  string public version = 'v0.1';
  uint256 public initialSupply;
  uint256 public totalSupply;
  bool public locked;
  //uint256 public unlockBlock;

  mapping(address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;


  /*
   *  The FaucetRLC Token created with the time at which the crowdsale end
   */

  constructor() public {
    initialSupply = 87000000000000000;
    totalSupply = initialSupply;
    balances[msg.sender] = initialSupply;// Give the creator all initial tokens
    name = 'iExec RLC Token';        // Set the name for display purposes
    symbol = 'RLC';                       // Set the symbol for display purposes
    decimals = 9;                        // Amount of decimals for display purposes
  }


  // function for Test net only. not in RLC Token
  function refill(address _to, uint256 _value) onlyOwner public returns (bool) {
    balances[_to] = safeAdd(balances[_to], _value);
    totalSupply = safeAdd(totalSupply, _value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  // function for Test net only. not in RLC Token
  function forceApprove(address _giver, address _spender, uint256 _value) onlyOwner public returns (bool) {
    allowed[_giver][_spender] = _value;
    emit Approval(_giver, _spender, _value);
    return true;
  }

  // function for Test net only. not in RLC Token
  function forceBurn(address _toburn, uint256 _value) onlyOwner public returns (bool){
    balances[_toburn] = safeSub(balances[_toburn], _value) ;
    totalSupply = safeSub(totalSupply, _value);
    emit Transfer(_toburn, address(0), _value);
    return true;
  }


  function burn(uint256 _value) public returns (bool){
    balances[msg.sender] = safeSub(balances[msg.sender], _value) ;
    totalSupply = safeSub(totalSupply, _value);
    emit Transfer(msg.sender, address(0), _value);
    return true;
  }

  function transfer(address _to, uint256 _value) public override returns (bool) {
    balances[msg.sender] = safeSub(balances[msg.sender], _value);
    balances[_to] = safeAdd(balances[_to], _value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {
    uint256 _allowance = allowed[_from][msg.sender];

    balances[_to] = safeAdd(balances[_to], _value);
    balances[_from] = safeSub(balances[_from], _value);
    allowed[_from][msg.sender] = safeSub(_allowance, _value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  function balanceOf(address _owner) public override view returns (uint256 balance) {
    return balances[_owner];
  }

  function approve(address _spender, uint256 _value) public override returns (bool) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

    /* Approve and then comunicate the approved contract in a single tx */
  function approveAndCall(address _spender, uint256 _value, bytes memory _extraData) public {
      TokenSpender spender = TokenSpender(_spender);
      if (approve(_spender, _value)) {
          spender.receiveApproval(msg.sender, _value, address(this), _extraData);
      }
  }

  function allowance(address _owner, address _spender) public override view returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

}
