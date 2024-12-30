// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from  "../test/Mocks/MarkV3aggregate.sol";

contract Helperconfig is Script {

    Networkconfig public activeNetworkConfig;
    uint8 public constant DECIMAL = 8;
    int256 public constant INTIAL_VAL = 2000e8;

    struct Networkconfig {
        address priceFeed;
    }

    constructor(){
        if(block.chainid == 11155111) {
            activeNetworkConfig = getSopoliaEthConfig();
        } else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSopoliaEthConfig() public pure returns(Networkconfig memory) {
        Networkconfig memory networkConfig = Networkconfig({
            priceFeed : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return networkConfig;
    }

    function getAnvilEthConfig() public  returns(Networkconfig memory) {
        if(activeNetworkConfig.priceFeed!=address(0)){
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mock = new MockV3Aggregator(DECIMAL, INTIAL_VAL);
        vm.stopBroadcast();

        Networkconfig memory networkConfig = Networkconfig({
            priceFeed : address(mock)
        });

        return networkConfig;
    }
}