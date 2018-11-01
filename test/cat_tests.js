// import { expectThrow } from 'openzeppelin-solidity/test/helpers/expectThrow'
import { shouldFail } from 'openzeppelin-solidity/test/helpers/shouldFail'
import { time } from 'openzeppelin-solidity/test/helpers/time'

const CatSale = artifacts.require('./CatSale.sol')
const MeowCoin = artifacts.require('./MeowCoin.sol')

const should = require('chai').should()

contract('CatSale Tests', function ([
  owner,
  wallet,
  catowner,
  catowner2,
  vandal
]) {
  let catSaleInstance
  let meowCoinInstance

  before(async function () {
    meowTokenInstance = await new MeowCoin()
    catSaleInstance = await new CatSale(
      1, // rate
      wallet, // wallet
      meowTokenInstance.address, // token
      now, // ico start
      now + time.duration.weeks * 2 // ico end
    )
  })

  it('MeowCoins can be minted', async function () {
    await meowCoinInstance.mint(owner, 1000, { from: owner })
    assert.equal(await meowCoinInstance.balances.call(owner), 1000)
  })
})
