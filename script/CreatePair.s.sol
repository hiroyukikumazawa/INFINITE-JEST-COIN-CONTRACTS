// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {InfiniteJestCoin} from "../src/InfiniteJestCoin.sol";
import {IUniswapV2Factory} from "../src/interfaces/IUniswapV2Factory.sol";
import {IUniswapV2Router02} from "../src/interfaces/IUniswapV2Router02.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";

contract CreatePairScript is Script {
    // Base Mainnet Uniswap V2 Factory Address
    address constant UNISWAP_V2_FACTORY = 0x8909Dc15e40173Ff4699343b6eB8132c65e18eC6;
    // Base Mainnet Uniswap V2 Router Address
    address constant UNISWAP_V2_ROUTER = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24;
    // Your IJC token address (replace with actual address after deployment)
    address constant IJC_TOKEN = address(0xA12Ab711be1057138779F99c1180f8082Da9dAb0); // Replace with your token address
    // WETH address on Base
    address constant WETH = 0x4200000000000000000000000000000000000006;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Create the pair
        IUniswapV2Factory factory = IUniswapV2Factory(UNISWAP_V2_FACTORY);
        address pair = factory.createPair(IJC_TOKEN, WETH);
        
        // Approve router to spend tokens
        IERC20(IJC_TOKEN).approve(UNISWAP_V2_ROUTER, type(uint256).max);

        // Add initial liquidity
        IUniswapV2Router02 router = IUniswapV2Router02(UNISWAP_V2_ROUTER);
        
        // Amount of IJC to add as liquidity (adjust as needed)
        uint256 ijcAmount = 100 * 10**18; // 100 IJC tokens
        
        // Add liquidity with ETH
        router.addLiquidityETH{value: 0.0012 ether}(
            IJC_TOKEN,
            ijcAmount,
            ijcAmount, // min IJC
            0.0012 ether, // min ETH
            msg.sender,
            block.timestamp + 15 minutes
        );

        vm.stopBroadcast();
    }
}
