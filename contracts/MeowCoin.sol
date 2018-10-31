pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/ownership/superuser.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract MeowCoin is ERC20Mintable, Superuser {
  // SafeMath is used for all math operations
  using SafeMath for uint256;

  string public constant symbol = "MEOW";
  string public constant name = "MeowCoin";
  uint8 public constant decimals = 18;
  uint8 public version = 1;

  // Cat Stats
  mapping(address => string) public catNames;
  mapping(address => uint256) public lastFed;
  mapping(address => uint256) public catBirthday;

  modifier catAlive(address catOwner) {
    require(isCatAlive(), "Your cat has 0 lives left :(");
    _;
  }

  // Pls take good care of your gentle feline
  function isCatAlive(address catOwner) public view {
    return balances[catOwner] > 0;
  }

  function checkCat(address catOwner) public catAlive(catOwner) {
    if (now - lastFed > 1 days) {
      uint256 memory daysSinceFed = (now - lastFed) / 1 days;
      // Cat is still alive but VERRY HONGRRY
      if (balances[catOwner] > daysSinceFed) {
        balances[catOwner] = balances[catOwner] - daysSinceFed;
      } else { // Cat is deceased, how could you
        balances[catOwner] = 0;
      }
    }
  }

  // Hip hip hooray, its yo cat's bday
  function summonCat(address catOwner) public onlyOwner {
    catBirthday[catOwner] = now;
    lastFed[catOwner] = now;
  }

  function getCatName(address catOwner) public view returns (string) {
    require(catNames[catOwner] != '', "This cat has no name");
    return catNames[catOwner];
  }

  function setCatName(string catName) public catAlive(msg.sender) {
    catNames[msg.sender] = catName;
  }

  function feedMyCat() public catAlive(msg.sender) {
    feedCat(msg.sender);
  }

  function feedCat(address catOwner) public catAlive(catowner) {
    lastFed[msg.sender] = now;
  }

}
