// Example deployment script using Hardhat
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);


  const presaleAddress: 0x833acAaC66D449aE0D51d55b4D5432FA24cb43D1
const liquidityPoolAddress: 0x2AeBbf3d2c40FAA8D4f57C2dc2338B7A9d13E83b
const marketingAddress: 0x8c7eb78541b247A5973090Bcb52b035996ea6757
const teamAddress: 0x9a1c64eaB64CE3E13e49B8D50d244aEF85C1c90D
const communityRewardsAddress:0x0d648853D8d79330E234B055351eDAB2c62fbCfA
const initialOwner: 0xaCFBAe0b31DC302C339b5d82e62F56c3Dc268D0F

  const DigiPegCoin = await ethers.getContractFactory("DigiPegCoin");
  const digiPegCoin = await DigiPegCoin.deploy(
    presaleAddress,
    liquidityPoolAddress,
    marketingAddress,
    teamAddress,
    communityRewardsAddress,
    initialOwner
  );

  console.log("DigiPegCoin deployed to:", digiPegCoin.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
