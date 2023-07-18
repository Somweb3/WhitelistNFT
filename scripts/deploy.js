const hre = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {
 const WhitelistContract = await hre.ethers.deployContract("WhitelistNFT", [10]);

  await WhitelistContract.waitForDeployment();

  console.log("Whitelist Contract Address:", WhitelistContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });