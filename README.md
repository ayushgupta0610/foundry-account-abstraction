## Foundry Account Abstraction Demo

**Demo repo for minimal smart contract wallets deployment with unique wallet instance per owner address**

This repo consists of:

-   **DeployMinimal.s.sol**: Deployment script for deploying a single instance of minimal account
-   **DeployMinimalAccountFactory.s.sol**: Deployment of factory contract to deploy factory minimal account deployment contract
-   **HelperConfig.s.sol**: HelperConfig to support deployment on different chains, such as Ethereum, Sepolia, Arbitrum, Anvil, zkSync (haven't tested)
-   **MinimalAccount**: Minimal smart contract wallet
-   **MinimalAccountFactory**: Minimal smart contract wallet to deploy multiple instances of minimal accounts. Note, an owner can only have a single instance of minimal account. 


## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil (for deployment on local network)

```shell
$ anvil
```

### Deploy and Verify 

```shell
$ forge script script/DeployMinimalAccountFactory.s.sol:DeployMinimalAccountFactory --rpc-url <NETWORK_RPC_URL> --broadcast --verify
```
