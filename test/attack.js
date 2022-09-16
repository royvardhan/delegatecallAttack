const { expect } = require("chai");
const { BigNumber } = require("ethers");
const { ethers, waffle } = require("hardhat");

describe("Initiate Attack", function () {
  it("Should change the owner of the Good contract", async function () {
    // Deploy the helper contract
    const helperFactory = await ethers.getContractFactory("Helper");
    const helper = await helperFactory.deploy();
    await helper.deployed();
    console.log(`Helper contract deployed at: ${helper.address}`);

    // Deploy the Good contract
    const goodFactory = await ethers.getContractFactory("Good");
    const good = await goodFactory.deploy(helper.address);
    await good.deployed;
    console.log(`Good contract deployed at: ${good.address}`);

    // Deploy the Attack contract
    const attackFactory = await ethers.getContractFactory("Attack");
    const attackContract = await attackFactory.deploy(good.address);
    await attackContract.deployed;
    console.log(`Attack contract deployed at: ${attackContract.address}`);

    // Now initiate the attack
    const tx = await attackContract.attack();
    await tx.wait();

    expect(attackContract.address).to.equal(await good.owner());
  });
});
