const { web3 } = hre;

describe("Uniswap code", function () {
  let swapcodes;
  let usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
  let weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  let tsx;

  network.provider.send("hardhat_setBalance", [
    "0xD625c7458Da1a0758dA8d3AC7f2c10180Bf0E506",
    ethers.utils.parseEther('1000.0').toHexString(),
  ]);

  it("should deploy main.sol", async function () {

    const swapCode = await hre.ethers.getContractFactory("swapCode");
    swapcodes = await swapCode.deploy();
    await swapcodes.deployed();

    console.log("Contract deployed to:", swapcodes.address);
  });

  it("should swap exact eth for usdc", async function () {

    tsx = await swapcodes.swapETHforUSDC("10000000000000000", "0xD625c7458Da1a0758dA8d3AC7f2c10180Bf0E506");
    console.log(tsx);

  });

});

  /*it(("should swap exact eth for usdc", async function () {
    tsx = await swapcodes.methods.swapdaiforEth*/

