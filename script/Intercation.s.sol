//fund
// withdrwal

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script,console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { FundMe } from "../src/FundMe.sol";

contract fundFundme is Script {
    uint256 constant SEND_VALUE = 0.1 ether;
    function fundfundme(address mostRecentDeploy ) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeploy)).fund{value : SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funde me with %s",SEND_VALUE);
    }

    function run() external {
        address mostRecentDeploy = DevOpsTools.get_most_recent_deployment("Fundme", block.chainid);
        fundfundme(mostRecentDeploy);
    }
}

contract WithDrawFundme is Script {}