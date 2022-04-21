require("dotenv").config({path: ".env"});
const { ethers } = require("hardhat");


async function main(){
    const metaDataUrl = "ipfs://Qmbygo38DWF1V8GttM1zy89KzyZTPU2FLUzQtiDvB7q6i5";

    const lw3PunksContract = await ethers.getContractFactory("LW3Punks");
    const deployedLW3PunksContract = await lw3PunksContract.deploy("metaDataUrl");
    await deployedLW3PunksContract.deployed()

    console.log("LW3Punks Contract Address:",deployedLW3PunksContract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
    console.log(error);
    process.exit(1);
    });