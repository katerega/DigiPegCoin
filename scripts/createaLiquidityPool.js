const Web3 = require('web3');
const { abi: factoryABI } = require('@pancakeswap/pancake-swap-periphery/build/IUniswapV2Factory.json');
const { abi: routerABI } = require('@pancakeswap/pancake-swap-periphery/build/IUniswapV2Router02.json');
const { abi: erc20ABI } = require('@openzeppelin/contracts/build/contracts/ERC20.json');
require('dotenv').config();

const web3 = new Web3(new Web3.providers.HttpProvider(process.env.BSC_RPC_URL));
const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);
web3.eth.defaultAccount = account.address;

const factoryAddress = '0xca143ce32fe78f1f7019d7d551a6402fc5350c73';
const routerAddress = '0x10ED43C718714eb63d5aA57B78B54704E256024E';

const dpcAddress = '0xYourDPCContractAddress'; // Replace with your deployed DPC contract address
const BNBAddress = '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE'; // Common representation for BNB

const factory = new web3.eth.Contract(factoryABI, factoryAddress);
const router = new web3.eth.Contract(routerABI, routerAddress);
const dpc = new web3.eth.Contract(erc20ABI, dpcAddress);

async function createLiquidityPool() {
    try {
        // Approve the router to spend your DPC tokens
        const amountDPC = web3.utils.toWei('60000', 'ether'); // 60000 DPC
        await dpc.methods.approve(routerAddress, amountDPC).send({ from: account.address });

        // Add liquidity to the pool
        const amountBNB = web3.utils.toWei('0.25', 'ether'); // 0.25 BNB ~ $80 (assuming BNB is $320)
        const amountDPCMin = web3.utils.toWei('0', 'ether'); // Minimum amount of DPC
        const amountBNBMin = web3.utils.toWei('0', 'ether'); // Minimum amount of BNB

        await router.methods.addLiquidityETH(
            dpcAddress,
            amountDPC,
            amountDPCMin,
            amountBNBMin,
            account.address,
            Math.floor(Date.now() / 1000) + 60 * 10 // 10 minutes deadline
        ).send({
            from: account.address,
            value: amountBNB
        });

        console.log('Liquidity added successfully');
    } catch (error) {
        console.error('Error adding liquidity:', error);
    }
}

createLiquidityPool();
