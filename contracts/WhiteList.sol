// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract WhitelistNFT is ERC721 {
    uint public maxWhitelistedAddresses;
    uint public numAddressesWhitelisted;
    bool public isInitialPhase;

    mapping(address => bool) public WhitelistedAddresses;
    mapping(address => bool) public hasMinted;
    uint256 private initialPhaseTokenIdCounter;
    uint256 private finalPhaseTokenIdCounter;
    address private owner;

    constructor(uint _maxWhitelistedAddresses) ERC721("WhiteList", "WL") {
        maxWhitelistedAddresses = _maxWhitelistedAddresses;
        isInitialPhase = true;
        initialPhaseTokenIdCounter = 0;
        finalPhaseTokenIdCounter = 0;
        numAddressesWhitelisted = 0;
        owner = msg.sender;
    }

    modifier onlyDuringInitialPhase() {
        require(isInitialPhase, "Function can only be called during the initial phase");
        _;
    }

    modifier hasNotMintedYet() {
        require(!hasMinted[msg.sender], "Address has already minted an NFT");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function addAddressToWhitelist() public onlyDuringInitialPhase {
        require(!WhitelistedAddresses[msg.sender], "Sender already in the whitelist");
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "Max limit reached");
        WhitelistedAddresses[msg.sender] = true;
        numAddressesWhitelisted += 1;
    }

    function removeAddressFromWhitelist() public onlyDuringInitialPhase {
        require(WhitelistedAddresses[msg.sender], "Sender not in the whitelist");
        WhitelistedAddresses[msg.sender] = false;
        numAddressesWhitelisted -= 1;
    }

    function isAddressWhitelisted(address wallet) public view returns (bool) {
        return WhitelistedAddresses[wallet];
    }

    function mint() external hasNotMintedYet {
        if(isInitialPhase){
            require(WhitelistedAddresses[msg.sender], "Address is not whitelisted during the initial phase");
            initialPhaseTokenIdCounter++;
            uint256 newTokenId = initialPhaseTokenIdCounter;
            _safeMint(msg.sender, newTokenId);
            hasMinted[msg.sender] = true;
        }
        else{
            finalPhaseTokenIdCounter++;
            uint256 newTokenId = finalPhaseTokenIdCounter;
            _safeMint(msg.sender, newTokenId);
        }
    }

    function setFinalPhase() external onlyOwner {
        require(isInitialPhase, "Already in the final phase");
        isInitialPhase = false;
    }
}
