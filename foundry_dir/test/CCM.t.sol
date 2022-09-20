// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

//  In order to be compatible with the previous hardhat test, two paths must be manually modified here, 
//  first is the scriptPath in CCM.t.sol to the absolute variable in the script.sh script, 
//  second is absolute path of Const.sol has to be correct within the script.sh script 
contract CCMTest is Test {
    address deployer=vm.addr(1);
    address add1=vm.addr(11);
    address add2=vm.addr(111);
    address eccd;
    address factory;
    string scriptPath="/home/lipu/crossChain2.1_with_foundry/eth-contracts/foundry_dir/test/script.sh";
    function setUp() public {
        eccd= deployCode("EthCrossChainData.sol");
        factory= deployCode("CallerFactory.sol",abi.encode(new address[](0)));
        updateConst(eccd,factory,scriptPath);
    }

    function testC()  public {
        
    }

    function updateConst(address eccdAddress, address factoryAddress, string memory _scriptPath)  internal {
        string memory eccdAddress=vm.toString(eccdAddress);
        string memory factoryAddress=vm.toString(factoryAddress);
        string memory constFileData=string.concat("pragma solidity ^0.5.0;contract Const {bytes constant ZionCrossChainManagerAddress = hex\"0000000000000000000000000000000000001003\";address constant EthCrossChainDataAddress=", eccdAddress, ";address constant EthCrossChainCallerFactoryAddress=" , factoryAddress, ";uint constant chainId = 79;address constant EVENT_WITNESS=0xA8a1c2E2739725a14072B0bB1C6FAb0B36C15952;}");   
        string[] memory inputs = new string[](3);
        inputs[0] = "bash";
        inputs[1] = scriptPath;
        inputs[2] = constFileData;
    }
}
