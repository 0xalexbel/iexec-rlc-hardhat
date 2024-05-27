// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.6.0;
//v0.1.0
interface TokenSpender {
    function receiveApproval(address _from, uint256 _value, address _token, bytes memory _extraData) external;
}