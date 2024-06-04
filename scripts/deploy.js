const DigiPegCoin = artifacts.require("DigiPegCoin");

module.exports = function (deployer, network, accounts) {
    const presaleAddress = accounts[1];
    const liquidityPoolAddress = accounts[2];
    const marketingAddress = accounts[3];
    const teamAddress = accounts[4];
    const communityRewardsAddress = accounts[5];

    deployer.deploy(DigiPegCoin, presaleAddress, liquidityPoolAddress, marketingAddress, teamAddress, communityRewardsAddress);
};
