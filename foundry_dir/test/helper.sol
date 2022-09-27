pragma solidity ^0.8.15;
import "forge-std/Test.sol";

import "test/interface/ICallerSigMsgGen.sol";
import "forge-std/console.sol";
import "test/interface/IEthCrossChainData.sol";
import "test/interface/IEthCrossChainCaller.sol";
import "test/interface/ICallerImplementationMock.sol";
import "test/interface/ICallerFactory.sol";
import "test/interface/IEthSigMsgGen.sol";
import "test/interface/ICallerImplementationMock_2.sol";
import "test/interface/IEthCrossChainManager.sol";
import "test/interface/IEthCrossChainManagerImplementation.sol";
import "test/interface/ITunnelCCMCaller.sol";
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