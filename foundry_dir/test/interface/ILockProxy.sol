pragma solidity ^0.8.10;

interface ILockProxy {
    event BindAssetEvent(address fromAssetHash, uint64 toChainId, bytes targetProxyHash, uint256 initialAmount);
    event BindProxyEvent(uint64 toChainId, bytes targetProxyHash);
    event LockEvent(
        address fromAssetHash, address fromAddress, uint64 toChainId, bytes toAssetHash, bytes toAddress, uint256 amount
    );
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event SetManagerProxyEvent(address manager);
    event UnlockEvent(address toAssetHash, address toAddress, uint256 amount);

    function assetHashMap(address, uint64) external view returns (bytes memory);
    function bindAssetHash(address fromAssetHash, uint64 toChainId, bytes memory toAssetHash) external returns (bool);
    function bindProxyHash(uint64 toChainId, bytes memory targetProxyHash) external returns (bool);
    function getBalanceFor(address fromAssetHash) external view returns (uint256);
    function isOwner() external view returns (bool);
    function lock(address fromAssetHash, uint64 toChainId, bytes memory toAddress, uint256 amount)
        external
        payable
        returns (bool);
    function managerProxyContract() external view returns (address);
    function owner() external view returns (address);
    function proxyHashMap(uint64) external view returns (bytes memory);
    function renounceOwnership() external;
    function setManagerProxy(address ethCCMProxyAddr) external;
    function transferOwnership(address newOwner) external;
    function unlock(bytes memory argsBs, bytes memory fromContractAddr, uint64 fromChainId) external returns (bool);
}