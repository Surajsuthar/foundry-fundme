// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Test } from "forge-std/Test.sol";
import { FundMe } from "../src/FundMe.sol";
import { DeployFundMe } from "../script/DeployfundMe.s.sol";

contract FundmeTest is Test {
    FundMe fundme;
    address USER = makeAddr("Suraj");
    uint256 constant SEND_VALUES = 0.1 ether;
    uint constant BALANACE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundme = new DeployFundMe();
        fundme = deployFundme.run();
        vm.deal(USER, BALANACE);
    }

    function testCheckUSD() view public {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }
    function testIsOwener() view public {
        assertEq(fundme.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIAccurate() view public{
        assertEq(fundme.getVersion(), 4);
    }

    function testFundFailsWithoutEnougheEth() public {
        vm.expectRevert();
        fundme.fund{value : SEND_VALUES }();
    }

    function testFundUpdatedFundDS() public {
        vm.prank(USER);
        fundme.fund{value : SEND_VALUES }();
        uint256 amountFunded = fundme.addressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUES);
    }

    function testAddFunderToArrOfFunders() public {
        vm.prank(USER);
        fundme.fund{value : SEND_VALUES }();
        address funder = fundme.getFunder(0);
        assertEq(funder, USER);
    }
}