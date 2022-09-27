pragma solidity ^0.8.10;

interface ITunnelCCMCaller {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function bindCallerHash(uint64 toChainId, bytes memory targetCallerHash) external;
    function callerHashMap(uint64) external view returns (bytes memory);
    function crossChain(uint64 _toChainId, bytes memory _toContract, bytes memory _method, bytes memory _txData)
        external
        returns (bool);
    function getEthCrossChainManager() external view returns (address);
    function initialize(address newOwner) external;
    function isOwner() external view returns (bool);
    function owner() external view returns (address);
    function realCCM() external view returns (address);
    function renounceOwnership() external;
    function setRealCCM(address _ccm) external;
    function transferOwnership(address newOwner) external;
    function unwrap(bytes memory args, bytes memory fromContractAddr, uint64 fromChainId) external returns (bool);
}