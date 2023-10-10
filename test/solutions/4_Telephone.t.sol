pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../../src/4_Telephone/TelephonFactory.sol";
import "../../src/Ethernaut.sol";
import "../../src/4_Telephone/Attack/Attacker.sol";
import ".././utils/vm.sol";

contract TelephoneTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();

        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testTelphoneHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        TelephoneFactory probFactory = new TelephoneFactory();
        ethernaut.registerLevel(probFactory);
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(probFactory);
        Telephone probCtrt = Telephone(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        emit log_named_uint("owner", uint160((address(probCtrt.owner()))));

        Attacker attacker = new Attacker(address(probCtrt));

        // change the owner
        attacker.attack(eoaAddress);

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
