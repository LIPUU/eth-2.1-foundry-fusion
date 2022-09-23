pragma solidity ^0.8.10;

interface ICallerSigMsgGen {
    function getSigMsg(uint256 _salt, address _logic, address _admin, bytes memory _data, address _factory)
        external
        pure
        returns (bytes32);
}