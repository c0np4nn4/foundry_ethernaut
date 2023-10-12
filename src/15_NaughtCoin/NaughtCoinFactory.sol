// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../BaseLevel.sol";
import "./NaughtCoin.sol";

contract NaughtCoinFactory is Level {
    function createInstance(address _player)
        public
        payable
        override
        returns (address)
    {
        return address(new NaughtCoin(_player));
    }

    function validateInstance(address payable _instance, address _player)
        public
        override
        returns (bool)
    {
        NaughtCoin instance = NaughtCoin(_instance);
        return instance.balanceOf(_player) == 0;
    }
}
