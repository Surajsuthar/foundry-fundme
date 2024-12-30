// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { FundMe } from "../src/FundMe.sol";
import { Helperconfig } from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    Helperconfig heplerConfig = new Helperconfig();
    address ethUsdpriceFeed = heplerConfig.activeNetworkConfig();
    function run() external returns(FundMe) {
        vm.startBroadcast();
        FundMe fundme = new FundMe(ethUsdpriceFeed);
        vm.stopBroadcast();
        return fundme;
    }
}