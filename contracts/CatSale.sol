pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol';

contract CatSale is Crowdsale {

  constructor(uint256 rate, address wallet, IERC20 token) {
    Crowdsale(rate, wallet, token);
  }

}
