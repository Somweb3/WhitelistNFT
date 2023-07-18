# WhitelistNFT Contract

The `WhitelistNFT` contract is an ERC-721 compliant smart contract that allows users to mint non-fungible tokens (NFTs) during an initial whitelist phase. After the initial phase, the contract enters a final phase where anyone can mint NFTs. The contract owner can control the whitelist phase and manage the maximum number of addresses allowed to participate in the whitelist.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Contract Details](#contract-details)
  - [Functions](#functions)
  - [Modifiers](#modifiers)
- [Usage](#usage)
  - [Whitelist Phase](#whitelist-phase)
  - [Final Phase](#final-phase)
- [License](#license)

## Overview

The contract is deployed as an ERC-721 token with the name "WhiteList" and symbol "WL". During the initial phase, only whitelisted addresses can mint NFTs, and each address is limited to one NFT. After the initial phase, any address can mint NFTs without any restrictions.

The contract owner has the ability to add or remove addresses from the whitelist during the initial phase. Additionally, the owner can transition the contract from the initial phase to the final phase.

## Prerequisites

To interact with the `WhitelistNFT` contract, you need to have access to an Ethereum wallet or an Ethereum development environment such as Hardhat or Remix. Make sure to have the appropriate development tools, such as Node.js and npm, installed on your machine.

## Deployment

Before deploying the contract, you need to set the value of `maxWhitelistedAddresses`, which defines the maximum number of whitelisted addresses during the initial phase. Adjust this value according to your requirements.

After configuring the contract, deploy it to the desired Ethereum network using your preferred Ethereum development environment, such as Hardhat or Remix.

## Contract Details

### Functions

- `addAddressToWhitelist()`: Allows the contract owner to add an address to the whitelist during the initial phase. The caller must be the contract owner, and the function can only be called during the initial phase.

- `removeAddressFromWhitelist()`: Allows the contract owner to remove an address from the whitelist during the initial phase. The caller must be the contract owner, and the function can only be called during the initial phase.

- `isAddressWhitelisted(address wallet)`: Checks whether an address is whitelisted during the initial phase.

- `mint()`: Allows users to mint NFTs during the whitelist phase (initial phase) if they are whitelisted. Each address can only mint one NFT during this phase. After the whitelist phase, any address can mint NFTs without any restrictions.

- `setFinalPhase()`: Transitions the contract from the initial phase to the final phase. Only the contract owner can call this function.

### Modifiers

- `onlyDuringInitialPhase()`: A modifier to restrict certain functions to be called only during the initial phase.

- `hasNotMintedYet()`: A modifier to ensure that an address can only mint one NFT during the whitelist phase.

- `onlyOwner()`: A modifier to restrict certain functions to be called only by the contract owner.

## Usage

### Whitelist Phase

During the whitelist phase (initial phase), only the contract owner can add addresses to the whitelist using the `addAddressToWhitelist()` function. Once an address is whitelisted, it can call the `mint()` function to mint one NFT.

### Final Phase

After the contract owner sets the final phase using the `setFinalPhase()` function, the contract enters the final phase. In this phase, any address can call the `mint()` function to mint NFTs without any restrictions. The whitelist phase restrictions no longer apply.

## License

This smart contract is released under the MIT License. You can find the full text of the license in the [LICENSE](LICENSE) file.