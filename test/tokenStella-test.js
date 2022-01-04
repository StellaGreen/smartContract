/* eslint-disable comma-dangle */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */

const { expect } = require('chai');
// const { ethers } = require('hardhat');
const { getContractAddress } = require('@ethersproject/address');

describe('TokenStella', function () {
  let TokenStella, tokenStella, dev, alice, bob, eve;

  const INITIAL_SUPPLY = ethers.utils.parseEther('8000');
  const NAME = 'StellaToken';
  const SYMBOL = 'STO';

  // it deploys first
  this.beforeEach(async function () {
    [dev, alice, bob, eve] = await ethers.getSigners();
    TokenStella = await ethers.getContractFactory('TokenStella');
    tokenStella = await TokenStella.connect(dev).deploy(dev.address, INITIAL_SUPPLY);
    await tokenStella.deployed();
  });
  it('has a name', async function () {
    expect(await tokenStella.name()).to.equal(NAME);
  });
  it('has a symbol', async function () {
    expect(await tokenStella.symbol()).to.equal(SYMBOL);
  });
  it('has 18 decimals', async function () {
    expect(await tokenStella.decimals()).to.equal('18');
  });

  // describe('Deployement', function () {
  //   it('should emit the event OwnershipTransferred correctly', async function () {
  //     await expect(token.deployTransaction)
  //       .to.emit(token, 'OwnershipTransferred')
  //       .withArgs(ethers.constants.AddressZero, dev.address);
  //   });
  // });
  // describe('functions', function () {
  //   it('should emit event ComEthCreated', async function () {
  //     await expect(tokenStella.connect(alice).createComEth(ethers.utils.parseEther('0.1')))
  //       .to.emit(tokenStella, 'ComEthCreated')
  //       .withArgs(futureAddress);
  //   });
  //   it('should return factoryOwner ', async function () {
  //     expect(await tokenStella.getFactoryOwner()).to.equal(dev.address);
  //   });
  // });
});
