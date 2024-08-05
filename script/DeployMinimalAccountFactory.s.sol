// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {MinimalAccountFactory} from "../src/ethereum/MinimalAccountFactory.sol";
import {MinimalAccount} from "../src/ethereum/MinimalAccount.sol";

contract DeployMinimalAccountFactory is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the WalletFactory
        MinimalAccountFactory factory = new MinimalAccountFactory();
        console.log("WalletFactory deployed at:", address(factory));

        // Create multiple MinimalAccount instances
        address[] memory owners = new address[](3);
        owners[0] = address(0x47D1111fEC887a7BEb7839bBf0E1b3d215669D86);
        owners[1] = address(0x1dBDbA98354729109dfad1C1dc603707a66cf506);
        owners[2] = address(0x534e9B3EA1F77f687074685a5F7C8a568eF6D586);

        for (uint256 i = 0; i < owners.length; i++) {
            address predictedAddress = factory.getAccountAddress(owners[i]);
            console.log("Predicted address for owner", owners[i], ":", predictedAddress);

            address actualAddress = factory.createAccount(owners[i]);
            console.log("Actual deployed address:", actualAddress);

            require(predictedAddress == actualAddress, "Predicted and actual addresses do not match");
            console.log("MinimalAccount created successfully");
            console.log("--------------------");
        }

        vm.stopBroadcast();
    }
}