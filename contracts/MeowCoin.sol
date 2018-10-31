pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/ownership/superuser.sol";

contract MeowCoin is ERC20Mintable, Superuser {

  string public constant symbol = "MEOW";
  string public constant name = "MeowCoin";
  uint8 public constant decimals = 18;
  uint8 public version = 1;

}
