pragma solidity ^0.8.10;

interface ICallerFactory {
    event ProxyCreated(address proxy);

    function deploy(uint256 _salt, address _logic, address _admin, bytes memory _data)
        external
        returns (address proxy);
    function deploySigned(uint256 _salt, address _logic, address _admin, bytes memory _data, bytes memory _signature)
        external
        returns (address proxy);
    function getDeploymentAddress(uint256 _salt, address _sender) external view returns (address);
    function getSigner(uint256 _salt, address _logic, address _admin, bytes memory _data, bytes memory _signature)
        external
        view
        returns (address);
    function isChild(address _addr) external view returns (bool);
}