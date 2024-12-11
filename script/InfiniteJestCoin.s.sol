// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {InfiniteJestCoin} from "../src/InfiniteJestCoin.sol";

contract InfiniteJestCoinScript is Script {
    InfiniteJestCoin public infiniteJestCoin;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        infiniteJestCoin = new InfiniteJestCoin("Infinite Jest Coin", "IJC", 18, 1000000000000000000000000000);

        vm.stopBroadcast();
    }
}
