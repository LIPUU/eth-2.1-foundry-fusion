pragma solidity ^0.8.15;
interface IEthSigMsgGen {
    function msgToEthSignedMessageHash(bytes memory _msg) external pure returns (bytes32);
    function toEthSignedMessageHash(bytes32 hash) external pure returns (bytes32);
}