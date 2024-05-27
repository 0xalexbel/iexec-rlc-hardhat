// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.6.0;
//v0.1.0
contract Ownable {
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if (msg.sender == owner)
      _;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    if (newOwner != address(0)) owner = newOwner;
  }

}