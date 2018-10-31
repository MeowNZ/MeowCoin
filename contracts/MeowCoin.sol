pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';

contract MeowCoin is ERC20 {

  string public symbol = "MEOW";
  string public name = "MeowCoin";
  uint8 public decimals = 18;
  uint8 public version = 1;


}
