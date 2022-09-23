pragma solidity ^0.8.15;
import "forge-std/Test.sol";

import "interface/ICallerSigMsgGen.sol";
import "forge-std/console.sol";
import "interface/IEthCrossChainData.sol";
import "interface/IEthCrossChainCaller.sol";
import "interface/ICallerImplementationMock.sol";
import "interface/ICallerFactory.sol";
import "interface/IEthSigMsgGen.sol";
import "interface/ICallerImplementationMock_2.sol";
import "interface/IEthCrossChainManager.sol";


contract Helper is Test {
    function updateConst(address _eccdAddress, address _factoryAddress, string memory _scriptPath)  public {
        string memory eccdAddress=vm.toString(_eccdAddress);
        string memory factoryAddress=vm.toString(_factoryAddress);
        string memory constFileData=string.concat("pragma solidity ^0.5.0;contract Const {bytes constant ZionCrossChainManagerAddress = hex\"0000000000000000000000000000000000001003\";address constant EthCrossChainDataAddress=", eccdAddress, ";address constant EthCrossChainCallerFactoryAddress=" , factoryAddress, ";uint constant chainId = 79;address constant EVENT_WITNESS=0xA8a1c2E2739725a14072B0bB1C6FAb0B36C15952;}");   
        string[] memory inputs = new string[](3);
        inputs[0] = "bash";
        inputs[1] = _scriptPath;
        inputs[2] = constFileData;
    }
}