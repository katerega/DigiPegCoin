// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IBEP20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract DigiPegCoin is ERC20, Ownable {
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
        address _communityRewardsAddress,
        address _initialOwner // Pass initial owner address here
    ) ERC20("DigiPegCoin", "DPC") Ownable(_initialOwner) {
        presaleAddress = _presaleAddress;
        liquidityPoolAddress = _liquidityPoolAddress;
        marketingAddress = _marketingAddress;
        teamAddress = _teamAddress;
        communityRewardsAddress = _communityRewardsAddress;

        uint256 INITIAL_SUPPLY = 100_000_000 * (10 ** uint256(decimals())); // 100 million tokens with 18 decimals

        _mint(msg.sender, INITIAL_SUPPLY * 5 / 100); // Owner gets 5%
        _mint(presaleAddress, INITIAL_SUPPLY * 60 / 100); // 60% for presale
        _mint(liquidityPoolAddress, INITIAL_SUPPLY * 20 / 100); // 20% for liquidity pool
        _mint(marketingAddress, INITIAL_SUPPLY * 5 / 100); // 5% for marketing
        _mint(teamAddress, INITIAL_SUPPLY * 10 / 100); // 10% for team and development
        _mint(communityRewardsAddress, INITIAL_SUPPLY * 5 / 100); // 5% for community rewards
    }
}
