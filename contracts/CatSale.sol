pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/ownable.sol";
import "./MeowCoin.sol";

contract MeowCoinTokenSale is MintedCrowdsale, Ownable {
    // SafeMath is used for all math operations
    using SafeMath for uint256;

    constructor(
      uint _rate,
      address _wallet,
      ERC20 _token,
      uint _icoStart,
      uint _icoEnd
    )
        public
        Crowdsale(_rate, _wallet, _token)
    {
        require(now < _icoStart);
        require(_icoStart < _icoEnd);

    }


    /// @notice verify if the investor can purchase token with the related amount
    /// @notice if prerequisites are not fulfilled, the transaction is reverted.
    /// @dev    Overriden from Crowdsale.sol
    /// @dev    Overriden by TimedCrowdsale.sol, WhitelistedCrowdsale.sol
    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount)
    internal
    view
    {
        super._preValidatePurchase(_beneficiary, _weiAmount);
    }

    /// @notice  calculate the token amount investor is purchasing based on ether invested
    /// @notice  getCurrentRate is called in order to calculate the best rate based on _weiAmount
    /// @param   _weiAmount the amount of wei investor is spending to purchase token
    /// @return the calculated token amount.
    /// @dev     Overriden from Crowdsale.sol
    function _getTokenAmount(uint256 _weiAmount) internal view returns (uint256) {
        return rate().mul(_weiAmount);
    }

    // /// @notice Determines if a crowdsale is closed and finalizable.
    // /// @return a bool that indicates if the crowdsale is closed.
    // /// @dev    Overriden from TimedCrowdsale.sol
    // /// @dev    Used by finalize as a requirement for finalization
    // function hasClosed() public view returns (bool) {
    //     return super.hasClosed();
    // }

    /// @notice Finalize the crowdsale in order to enable refund (in case goal is not reached) or
    /// @notice withdraw collected ether from the escrow contract (in case goal is successfully reached)
    /// @dev    Overriden from FinalizableCrowdsale.sol
    /// @dev    Overriden by RefundableCrowdsale.sol
    // function finalization() internal {
    //     super.finalization();

    //     MeowCoin(token).finishMinting();
    //     MeowCoin(token).unpause();
    //     MeowCoin(token).transferOwnership(owner);
    // }

    // TODO add fallback function
}
