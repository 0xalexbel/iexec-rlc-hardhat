// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.6.0;
//v0.1.0
interface ERC20 {
  function balanceOf(address who) external view returns (uint256);
  function allowance(address owner, address spender) external view returns (uint256);

  function transfer(address to, uint256 value) external returns (bool ok);
  function transferFrom(address from, address to, uint256 value) external returns (bool ok);
  function approve(address spender, uint256 value) external returns (bool ok);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}
