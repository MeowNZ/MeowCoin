pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/ownership/ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract MeowCoin is ERC20Mintable, ERC20Burnable, Ownable {
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

  function compareStrings(string _a, string _b) returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (b.length < minLength) minLength = b.length;
        //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
        for (uint i = 0; i < minLength; i ++)
            if (a[i] < b[i])
                return -1;
            else if (a[i] > b[i])
                return 1;
        if (a.length < b.length)
            return -1;
        else if (a.length > b.length)
            return 1;
        else
            return 0;
    }

  modifier catAlive(address catOwner) {
    require(isCatAlive(catOwner), "Your cat has 0 lives left :(");
    _;
  }
  // Pls take good care of your gentle feline
  function isCatAlive(address catOwner) public view returns (bool) {
    return balanceOf(catOwner) > 0;
  }

  function checkCat(address catOwner) public catAlive(catOwner) {
    if (now - lastFed[catOwner] > 1 days) {
      uint256 daysSinceFed = (now - lastFed[catOwner]) / 1 days;
      // Cat is still alive but VERRY HONGRRY
      if (balanceOf(catOwner) > daysSinceFed) {
        burn(daysSinceFed);
      } else { // Cat is deceased, how could you
        burn(balanceOf(catOwner));
      }
    }
  }

  function patCat(address catOwner) public {
    checkCat(catOwner);
    require(isCatAlive(catOwner), "Please only pat cats that are alive");
    // It's so happy ^_^
  }

  // Hip hip hooray, its yo cat's bday
  function summonCat(address catOwner) public onlyOwner {
    catBirthday[catOwner] = now;
    lastFed[catOwner] = now;
  }

  function getCatName(address catOwner) public view returns (string) {
    require(compareStrings(catNames[catOwner], "") != 1, "This cat has no name");
    return catNames[catOwner];
  }

  function setCatName(string catName) public catAlive(msg.sender) {
    catNames[msg.sender] = catName;
  }

  function feedMyCat() public catAlive(msg.sender) {
    feedCat(msg.sender);
  }

  function feedCat(address catOwner) public catAlive(catOwner) {
    lastFed[msg.sender] = now;
  }

  // Override
  function transfer(address to, uint256 value) public returns (bool) {
    checkCat(msg.sender);
    super.transfer(to, value);
  }
}
