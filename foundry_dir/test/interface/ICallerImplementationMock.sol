pragma solidity ^0.8.10;
interface ICallerImplementationMock {
    function ccm() external view returns (address);
    event Unlock(address ccm, bytes args, bytes fromContract, uint64 fromChainId);

    // initialize只能被调用一次
    function initialize(address) external;
    function lock(bytes memory) external;
    function unlock(bytes memory , bytes memory , uint64 ) external returns(bool);
    function whoAmI() external pure returns(uint);
}