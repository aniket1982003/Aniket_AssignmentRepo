// 0xdc27B8c5C4f72583A28F60D475D484aaF5eBa01f
require('dotenv').config();
const hre = require("hardhat");
const abi = require("../artifacts/contracts/BuyMeACoffee.sol/BuyMeACoffee.json");

async function getBalance(provider, address) {
    const balanceBigInt = await provider.getBalance(address);
    return hre.ethers.utils.formatEther(balanceBigInt);
}

async function main() {
    const contractAddress = "0xdc27B8c5C4f72583A28F60D475D484aaF5eBa01f";
    const contractABI = abi.abi;

    // Use "matic" as the network name for Polygon
    const provider = new hre.ethers.providers.AlchemyProvider("matic", process.env.POLYGON_API_KEY);

    const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

    const buyMeACoffee = new hre.ethers.Contract(contractAddress, contractABI, signer);

    console.log("current balance of owner: ", await getBalance(provider, signer.address), "MATIC");
    const contractBalance = await getBalance(provider, buyMeACoffee.address);
    console.log("current balance of contract: ", await getBalance(provider, buyMeACoffee.address), "MATIC");

    if (contractBalance !== "0.0") {
        console.log("withdrawing funds...");
        const withdrawTxn = await buyMeACoffee.withdrawTips();
        await withdrawTxn.wait();
    } else {
        console.log("no funds to withdraw!");
    }

    console.log("current balance of owner: ", await getBalance(provider, signer.address), "MATIC");
}1````````````````

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
