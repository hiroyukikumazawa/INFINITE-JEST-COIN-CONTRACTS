include .env

deploy:
	@forge create src/InfiniteJestCoin.sol:InfiniteJestCoin --constructor-args "Infinite Jest Coin" "IJC" 18 1000000000000000000000000000 --rpc-url https://base-sepolia-rpc.publicnode.com --private-key ${PRIVATE_KEY}
