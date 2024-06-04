// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DigiPegCoin is ERC20, Ownable {
    uint256 public constant INITIAL_SUPPLY = 100_000_000 * (10 ** 18); // 100 million tokens with 18 decimals

    address public presaleAddress;
    address public liquidityPoolAddress;
    address public marketingAddress;
    address public teamAddress;
    address public communityRewardsAddress;

    constructor(
        address _presaleAddress,
        address _liquidityPoolAddress,
        address _marketingAddress,
        address _teamAddress,
        address _communityRewardsAddress
    ) ERC20("DigiPegCoin", "DPC") {
        presaleAddress = _presaleAddress;
        liquidityPoolAddress = _liquidityPoolAddress;
        marketingAddress = _marketingAddress;
        teamAddress = _teamAddress;
        communityRewardsAddress = _communityRewardsAddress;

        _mint(msg.sender, INITIAL_SUPPLY * 5 / 100); // Owner gets 5%
        _mint(presaleAddress, INITIAL_SUPPLY * 60 / 100); // 60% for presale
        _mint(liquidityPoolAddress, INITIAL_SUPPLY * 20 / 100); // 20% for liquidity pool
        _mint(marketingAddress, INITIAL_SUPPLY * 5 / 100); // 5% for marketing
        _mint(teamAddress, INITIAL_SUPPLY * 10 / 100); // 10% for team and development
        _mint(communityRewardsAddress, INITIAL_SUPPLY * 5 / 100); // 5% for community rewards
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}

