pragma solidity ^0.8.10;

interface IEthCrossChainCaller {
    event AdminChanged(address previousAdmin, address newAdmin);
    event Upgraded(address indexed implementation);

    function admin() external returns (address);
    function changeAdmin(address newAdmin) external;
    function implementation() external returns (address);
    function initialize(address _logic, address _admin, bytes memory _data) external payable;
    function initialize(address _logic, bytes memory _data) external payable;
    function upgradeTo(address newImplementation) external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}