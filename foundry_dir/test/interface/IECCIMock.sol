pragma solidity ^0.8.10;

interface IECCIMock {
    function _fromChainId() external view returns (uint64);
    function _fromContract() external view returns (bytes memory);
    function _method() external view returns (bytes memory);
    function _toChainId() external view returns (uint64);
    function _toContract() external view returns (bytes memory);
    function _txData() external view returns (bytes memory);
    function clearStorage() external;
    function crossChain(uint64 toChainId, bytes memory toContract, bytes memory method, bytes memory txData)
        external
        returns (bool);
    function iAmMock() external pure returns (bool);
    function verifyHeaderAndExecuteTx(
        bytes memory toContract,
        bytes memory method,
        bytes memory args,
        bytes memory fromContract,
        uint64 fromChainId
    ) external returns (bool);
}