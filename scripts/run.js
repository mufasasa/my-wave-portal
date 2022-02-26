const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);


  let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);

  console.log("Contract Balance: ", hre.ethers.utils.formatEther(contractBalance));

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log(waveCount.toNumber());

  let waveTxn1 = await waveContract.wave("this is wave 1");
  await waveTxn1.wait();

  let waveTxn2 = await waveContract.wave("this is wave 2");
  await waveTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log("Contract Balance: ", hre.ethers.utils.formatEther(contractBalance));

  waveCount = await waveContract.getTotalWaves();


  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();