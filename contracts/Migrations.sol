// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.6.0;
import "./Ownable.sol";

contract Migrations is Ownable {
    uint public lastCompletedMigration;

    function setCompleted(uint completed) public onlyOwner {
        lastCompletedMigration = completed;
    }

    function upgrade(address newAddress) public onlyOwner {
        Migrations upgraded = Migrations(newAddress);
        upgraded.setCompleted(lastCompletedMigration);
    }
}