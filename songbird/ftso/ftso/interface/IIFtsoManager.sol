// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6 <0.9;

import "./IIFtso.sol";
import "../../userInterfaces/IFtsoManager.sol";
import "../../../util-contracts/token/token/interface/IIVPToken.sol";

interface IIFtsoManager is IFtsoManager {

    event ClosingExpiredRewardEpochFailed(uint256 _rewardEpoch);
    event CleanupBlockNumberManagerUnset();
    event CleanupBlockNumberManagerFailedForBlock(uint256 blockNumber);

    function activate() external;

    function setGovernanceParameters(
        uint256 _maxVotePowerNatThresholdFraction,
        uint256 _maxVotePowerAssetThresholdFraction,
        uint256 _lowAssetUSDThreshold,
        uint256 _highAssetUSDThreshold,
        uint256 _highAssetTurnoutThresholdBIPS,
        uint256 _lowNatTurnoutThresholdBIPS,
        uint256 _rewardExpiryOffsetSeconds,
        address[] memory _trustedAddresses
    ) external;

    function addFtso(IIFtso _ftso) external;

    function removeFtso(IIFtso _ftso) external;

    function replaceFtso(
        IIFtso _ftsoToRemove,
        IIFtso _ftsoToAdd,
        bool copyCurrentPrice,
        bool copyAssetOrAssetFtsos
    ) external;

    function setFtsoAsset(IIFtso _ftso, IIVPToken _asset) external;

    function setFtsoAssetFtsos(IIFtso _ftso, IIFtso[] memory _assetFtsos) external;

    function setFallbackMode(bool _fallbackMode) external;

    function setFtsoFallbackMode(IIFtso _ftso, bool _fallbackMode) external;

    function settings() external view 
        returns (
            uint256 _maxVotePowerNatThresholdFraction,
            uint256 _maxVotePowerAssetThresholdFraction,
            uint256 _lowAssetUSDThreshold,
            uint256 _highAssetUSDThreshold,
            uint256 _highAssetTurnoutThresholdBIPS,
            uint256 _lowNatTurnoutThresholdBIPS,
            uint256 _rewardExpiryOffsetSeconds,
            bool _initialized,
            bool _changed
    );

    function rewardEpochs(uint256 _rewardEpochId) external view
        returns (
            uint256 _votepowerBlock,
            uint256 _startBlock,
            uint256 _startTimestamp
    );
}