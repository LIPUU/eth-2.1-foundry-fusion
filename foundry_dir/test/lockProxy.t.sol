pragma solidity ^0.8.0;
import "test/helper.sol";

contract LockProxy is Test {
    address deployer=vm.addr(1);
    address addr1=vm.addr(11);
    address addr2=vm.addr(0x64);
    
    address factory;
    address ccmiMock;
    address ccmp;
    address lockProxy;
    address tunnelCCMCaller;
    function setUp() public {
        vm.startPrank(deployer);
        factory= deployCode("CallerFactory.sol",abi.encode(new address[](0)));
        ccmiMock=deployCode("CCMMock.sol");
        ccmp=deployCode("EthCrossChainManager.sol",abi.encode(ccmiMock,deployer,""));
        lockProxy=deployCode("LockProxy.sol");
        tunnelCCMCaller=deployCode("TunnelCCMCaller.sol");
        vm.stopPrank();

        ITunnelCCMCaller(tunnelCCMCaller).setRealCCM(ccmp);
        
    }
    
    function testLockProxy() public {

    }

}