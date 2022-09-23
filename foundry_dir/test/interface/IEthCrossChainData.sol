pragma solidity ^0.8.10;

interface IEthCrossChainData {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Paused(address account);
    event Unpaused(address account);

    function CurEpochEndHeight() external view returns (uint64);
    function CurEpochId() external view returns (uint64);
    function CurEpochStartHeight() external view returns (uint64);
    function CurValidatorPkBytes() external view returns (bytes memory);
    function EthToPolyTxHashIndex() external view returns (uint256);
    function EthToPolyTxHashMap(uint256) external view returns (bytes32);
    function ExtraData(bytes32, bytes32) external view returns (bytes memory);
    function checkIfFromChainTxExist(uint64 fromChainId, bytes32 fromChainTx) external view returns (bool);
    function getCurEpochEndHeight() external view returns (uint64);
    function getCurEpochId() external view returns (uint64);
    function getCurEpochStartHeight() external view returns (uint64);
    function getCurEpochValidatorPkBytes() external view returns (bytes memory);
    function getEthTxHash(uint256 ethTxHashIndex) external view returns (bytes32);
    function getEthTxHashIndex() external view returns (uint256);
    function getExtraData(bytes32 key1, bytes32 key2) external view returns (bytes memory);
    function isOwner() external view returns (bool);
    function markFromChainTxExist(uint64 fromChainId, bytes32 fromChainTx) external returns (bool);
    function owner() external view returns (address);
    function pause() external returns (bool);
    function paused() external view returns (bool);
    function putCurEpochEndHeight(uint64 endHeight) external returns (bool);
    function putCurEpochId(uint64 epochId) external returns (bool);
    function putCurEpochStartHeight(uint64 startHeight) external returns (bool);
    function putCurEpochValidatorPkBytes(bytes memory curEpochPkBytes) external returns (bool);
    function putEthTxHash(bytes32 ethTxHash) external returns (bool);
    function putExtraData(bytes32 key1, bytes32 key2, bytes memory value) external returns (bool);
    function renounceOwnership() external;
    function transferOwnership(address newOwner) external;
    function unpause() external returns (bool);
}