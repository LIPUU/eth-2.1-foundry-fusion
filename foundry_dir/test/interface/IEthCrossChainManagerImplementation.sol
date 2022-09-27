pragma solidity ^0.8.10;
interface IEthCrossChainManagerImplementation {

    event InitGenesisBlockEvent(uint256 height, bytes rawHeader);
    event ChangeEpochEvent(uint256 height, bytes rawHeader, address[] oldValidators, address[] newValidators);
    event CrossChainEvent(address indexed sender, bytes txId, address proxyOrAssetContract, uint64 toChainId, bytes toContract, bytes rawdata);
    event VerifyHeaderAndExecuteTxEvent(uint64 fromChainID, bytes toContract, bytes crossChainTxHash, bytes fromChainTxHash);
 
    function getZionChainId() external pure returns(uint);
    
    function getEthCrossChainDataAddress() external pure returns(address);

    function getEthCrossChainManager() external view returns(address);

    function getEthCrossChainCallerFactoryAddress() external pure returns(address);
    
    function initGenesisBlock(bytes memory rawHeader) external returns(bool);
    
    function changeEpoch(bytes memory rawHeader, bytes memory rawSeals) external returns(bool);
    
    function crossChain(uint64 toChainId, bytes calldata toContract, bytes calldata method, bytes calldata txData) external returns (bool);

    function verifyHeaderAndExecuteTx(bytes memory rawHeader,bytes memory rawSeals,bytes memory accountProof, bytes memory storageProof,bytes memory rawCrossTx) external returns (bool);
}