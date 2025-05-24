// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";
import {console} from "forge-std/console.sol";

contract DeployRaffle is Script {
    function run() public {
        vm.startBroadcast();
        (Raffle raffle, HelperConfig helperConfig) = deployContract();
        vm.stopBroadcast();

        console.log("Raffle contract deployed to: ", address(raffle));
        console.log(
            "HelperConfig contract deployed to: ",
            address(helperConfig)
        );
    }

    function deployContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.vrfCoordinator,
            config.gasLane,
            config.subscriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();
        return (raffle, helperConfig);
    }
}
